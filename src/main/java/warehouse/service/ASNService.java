package warehouse.service;

import warehouse.dao.ASNDao;
import warehouse.model.ASN;

import java.sql.SQLException;
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
            // Populate items for each ASN
            for (ASN asn : asns) {
                asn.setItems(asnDao.getItemsForASN(asn.getAsnId()));
            }
            return asns;
        } catch (SQLException e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }
}
