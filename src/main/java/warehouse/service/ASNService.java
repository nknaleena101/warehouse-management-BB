package warehouse.service;

import warehouse.dao.ASNDao;
import warehouse.model.ASN;
import warehouse.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class ASNService {
    private ASNDao asnDao;

    public ASNService() {
        this.asnDao = new ASNDao();
    }

    public boolean createASN(ASN asn) {
        try {
            asnDao.createASN(asn);
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<ASN> getAllASNs() {
        try {
            List<ASN> asns = asnDao.getAllASNs();
            for (ASN asn : asns) {
                // Make sure this line is loading items for each ASN
                asn.setItems(asnDao.getItemsForASN(asn.getAsnId()));
            }
            return asns;
        } catch (SQLException e) {
            e.printStackTrace();
            return new ArrayList<>(); // Return empty list instead of null
        }
    }

    public List<ASN> getRecentASNs(int count) throws SQLException {
        List<ASN> asns = new ArrayList<>();
        String sql = "SELECT asn_id, supplier_name, expected_delivery_date, status " +
                "FROM asn_data ORDER BY created_at DESC LIMIT ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, count);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                ASN asn = new ASN();
                asn.setAsnId(rs.getInt("asn_id"));
                asn.setSupplierName(rs.getString("supplier_name"));
                asn.setExpectedDeliveryDate(rs.getDate("expected_delivery_date"));
                asn.setStatus(rs.getString("status"));
                asns.add(asn);
            }
        }
        return asns;
    }
    public List<ASN> getASNsByStatus(String status) throws SQLException {
        List<ASN> asns = new ArrayList<>();
        String sql = "SELECT * FROM asn_data WHERE status = ? ORDER BY expected_delivery_date";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                ASN asn = new ASN();
                asn.setAsnId(rs.getInt("asn_id"));
                asn.setSupplierName(rs.getString("supplier_name"));
                asn.setExpectedDeliveryDate(rs.getDate("expected_delivery_date"));
                asn.setStatus(rs.getString("status"));
                asns.add(asn);
            }
        }
        return asns;
    }
}
