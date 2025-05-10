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
        request.setAttribute("/jsp/asnList", asnList);
        request.getRequestDispatcher("/jsp/asnList.jsp").forward(request, response);
    }
}
