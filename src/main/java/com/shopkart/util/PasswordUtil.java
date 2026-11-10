
package com.shopkart.util;

import java.security.MessageDigest;
import java.security.SecureRandom;
import java.security.spec.KeySpec;
import java.util.Base64;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

public class PasswordUtil {

    // Generate password hash
    public static String hashPassword(String password) {

        try {
            byte[] salt = new byte[16];

            SecureRandom random = new SecureRandom();
            random.nextBytes(salt);

            KeySpec spec = new PBEKeySpec(
                    password.toCharArray(),
                    salt,
                    65536,
                    256
            );

            SecretKeyFactory factory =
                    SecretKeyFactory.getInstance(
                            "PBKDF2WithHmacSHA256"
                    );

            byte[] hash =
                    factory.generateSecret(spec).getEncoded();

            return Base64.getEncoder().encodeToString(salt)
                    + ":"
                    + Base64.getEncoder().encodeToString(hash);

        } catch (Exception e) {
            throw new RuntimeException(
                    "Password hashing failed", e
            );
        }
    }

    // Verify entered password with stored hash
    public static boolean verifyPassword(
            String password,
            String storedPassword) {

        try {
            String[] parts = storedPassword.split(":");

            if (parts.length != 2) {
                return false;
            }

            byte[] salt =
                    Base64.getDecoder().decode(parts[0]);

            byte[] storedHash =
                    Base64.getDecoder().decode(parts[1]);

            KeySpec spec = new PBEKeySpec(
                    password.toCharArray(),
                    salt,
                    65536,
                    256
            );

            SecretKeyFactory factory =
                    SecretKeyFactory.getInstance(
                            "PBKDF2WithHmacSHA256"
                    );

            byte[] enteredHash =
                    factory.generateSecret(spec).getEncoded();

            return MessageDigest.isEqual(
                    storedHash,
                    enteredHash
            );

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
