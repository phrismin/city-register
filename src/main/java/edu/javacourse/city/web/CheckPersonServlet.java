package edu.javacourse.city.web;

import edu.javacourse.city.dao.PersonCheckDao;
import edu.javacourse.city.domain.PersonRequest;
import edu.javacourse.city.domain.PersonResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet(name = "CheckPersonServlet", urlPatterns = {"/checkPerson"})
public class CheckPersonServlet extends HttpServlet {
  private PersonCheckDao dao;
  private static final Logger logger = LoggerFactory.getLogger(CheckPersonServlet.class);

  @Override
  public void init() throws ServletException {
    logger.info("SERVLET IS CREATED");
    dao = new PersonCheckDao();
  }

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    req.setCharacterEncoding("UTF-8");

    String surname = req.getParameter("surname");
    PersonRequest pr = new PersonRequest();
    pr.setSurName(surname);
    pr.setGivenName("Павел");
    pr.setPatronymic("Николаевич");
    pr.setDateOfBirth(LocalDate.of(1995, 3, 18));
    pr.setStreetCode(1);
    pr.setBuilding("10");
    pr.setExtension("2");
    pr.setApartment("121");

    try {
      PersonCheckDao dao = new PersonCheckDao();
      PersonResponse ps = dao.checkPerson(pr);
      if (ps.isRegistered()) {
        resp.getWriter().write("Registered");
      } else {
        resp.getWriter().write("Not registered");
      }
    } catch (Exception ex) {
      ex.printStackTrace();
    }
  }
}

