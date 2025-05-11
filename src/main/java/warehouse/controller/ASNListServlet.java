package warehouse.controller;

import warehouse.model.ASN;
import warehouse.service.ASNService;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;


@WebServlet("/asn/list")
public class ASNListServlet extends HttpServlet {
    private ASNService asnService;

    @Override
    public void init() {
        asnService = new ASNService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<ASN> asnList = asnService.getAllASNs();
        System.out.println("[DEBUG] Found " + asnList.size() + " ASNs"); // Add this line

        for (ASN asn : asnList) {
            System.out.println("[DEBUG] ASN ID: " + asn.getAsnId() +
                    " has " + (asn.getItems() != null ? asn.getItems().size() : 0) + " items");
        }

        request.setAttribute("asnList", asnList);
        request.getRequestDispatcher("/jsp/asnList.jsp").forward(request, response);
    }
}
