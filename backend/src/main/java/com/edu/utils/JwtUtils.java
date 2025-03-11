package com.edu.utils;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.Date;

public class JwtUtils {
    private static final String SECRET = System.getenv("JWT_SECRET") != null ?
            System.getenv("JWT_SECRET") : "defaultStrongSecretKeyWith32BytesLength!";

    private static final SecretKey KEY = Keys.hmacShaKeyFor(SECRET.getBytes(StandardCharsets.UTF_8));

    private static final long EXPIRATION = 1000 * 60 * 5;

    public static String generateToken(String userId) {
        return Jwts.builder()
                .issuer("edu-system")
                .subject(userId)
                .expiration(new Date(System.currentTimeMillis() + EXPIRATION))
                .signWith(KEY)
                .compact();
    }

    public static Claims parseToken(String token) {
        return Jwts.parser()
                .verifyWith(KEY)
                .requireIssuer("edu-system")
                .build()
                .parseSignedClaims(token)
                .getPayload();
    }

    public static boolean validateToken(String token) {
        try {
            parseToken(token);
            return true;
        } catch (JwtException e) {
            return false;
        }
    }
}
