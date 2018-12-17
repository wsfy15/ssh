package utils;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class hibernateUtils {
    private static SessionFactory sessionFactory;
    static {
         sessionFactory = new Configuration().configure().buildSessionFactory();
    }
    public static Session getSession() {
        return sessionFactory.openSession();
    }
}
