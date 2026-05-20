export interface HotPotatoJwtPayload {
  roomId: string;
  uid: string;
  path: string;
  edgeLocationHint: string;
  exp: number;
}

function base64UrlDecode(input: string): string {
  const pad = input.length % 4 === 0 ? "" : "=".repeat(4 - (input.length % 4));
  const b64 = input.replace(/-/g, "+").replace(/_/g, "/") + pad;
  const binary = atob(b64);
  const bytes = new Uint8Array(binary.length);
  for (let i = 0; i < binary.length; i++) bytes[i] = binary.charCodeAt(i);
  return new TextDecoder().decode(bytes);
}

function base64UrlEncode(bytes: ArrayBuffer): string {
  const bin = String.fromCharCode(...new Uint8Array(bytes));
  return btoa(bin).replace(/\+/g, "-").replace(/\//g, "_").replace(/=+$/g, "");
}

export async function verifyHotPotatoJwt(
  token: string,
  secret: string,
): Promise<HotPotatoJwtPayload | null> {
  try {
    if (!secret || !token.trim()) return null;
    const parts = token.split(".");
    if (parts.length !== 3) return null;
    const [headerB64, payloadB64, sigB64] = parts;
    const key = await crypto.subtle.importKey(
      "raw",
      new TextEncoder().encode(secret),
      { name: "HMAC", hash: "SHA-256" },
      false,
      ["verify"],
    );
    const data = new TextEncoder().encode(`${headerB64}.${payloadB64}`);
    let sig: Uint8Array;
    try {
      sig = Uint8Array.from(
        atob(sigB64.replace(/-/g, "+").replace(/_/g, "/")),
        (c) => c.charCodeAt(0),
      );
    } catch {
      return null;
    }
    const ok = await crypto.subtle.verify("HMAC", key, sig, data);
    if (!ok) return null;
    let payload: HotPotatoJwtPayload;
    try {
      payload = JSON.parse(base64UrlDecode(payloadB64)) as HotPotatoJwtPayload;
    } catch {
      return null;
    }
    if (!payload.roomId || !payload.uid || !payload.path) return null;
    if (payload.exp * 1000 < Date.now()) return null;
    return payload;
  } catch {
    return null;
  }
}

export const VALID_LOCATION_HINTS = new Set([
  "wnam",
  "enam",
  "sam",
  "weur",
  "eeur",
  "apac",
  "oc",
  "afr",
  "me",
]);

export type HotPotatoLocationHint =
  | "wnam"
  | "enam"
  | "sam"
  | "weur"
  | "eeur"
  | "apac"
  | "oc"
  | "afr"
  | "me";

export function resolveLocationHint(hint: string): HotPotatoLocationHint {
  if (VALID_LOCATION_HINTS.has(hint)) {
    return hint as HotPotatoLocationHint;
  }
  return "apac";
}
