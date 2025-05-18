package warehouse.service;

import warehouse.dao.StatsDAO;

public class StatsService {
    private StatsDAO statsDAO;

    public StatsService() {
        this.statsDAO = new StatsDAO();
    }

    public int getTotalProductsCount() throws Exception {
        return statsDAO.getTotalProductsCount();
    }

    public int getPendingOrdersCount() throws Exception {
        return statsDAO.getPendingOrdersCount();
    }

    public int getShippedOrdersCount() throws Exception {
        return statsDAO.getShippedOrdersCount();
    }

    public int getExpectedOrdersCount() throws Exception {
        return statsDAO.getExpectedOrdersCount();
    }
}