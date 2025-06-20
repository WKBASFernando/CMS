package com.ijse.cms.crud;

import javax.sql.DataSource;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class IdGeneratorWithPrefix {

    public static String generateNextId(DataSource conn, String tableName, String idColumn,
                                        String prefix, int numberLength) throws SQLException {
        String sql = "SELECT MAX(" + idColumn + ") AS max_id FROM " + tableName + " WHERE " + idColumn + " LIKE ?";

        try (PreparedStatement ps = conn.getConnection().prepareStatement(sql)) {
            ps.setString(1, prefix + "%");  // only IDs starting with prefix

            try (ResultSet rs = ps.executeQuery()) {
                String maxId = null;
                if (rs.next()) {
                    maxId = rs.getString("max_id");
                }

                if (maxId == null) {
                    // No IDs yet, start from 1
                    return prefix + String.format("%0" + numberLength + "d", 1);
                }

                // Extract number part using regex
                Pattern pattern = Pattern.compile(Pattern.quote(prefix) + "(\\d+)");
                Matcher matcher = pattern.matcher(maxId);

                int number = 0;
                if (matcher.find()) {
                    number = Integer.parseInt(matcher.group(1));
                }

                // Increment number
                number++;

                // Format with leading zeros
                return prefix + String.format("%0" + numberLength + "d", number);
            }
        }
    }
}
