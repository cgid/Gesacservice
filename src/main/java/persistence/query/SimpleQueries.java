/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package persistence.query;

import cell.Cell;
import entities.exceptions.NotIsUpgradeableEntityException;
import entities.exceptions.NotIsInsertableEntityException;
import entities.exceptions.NotIsSelectableEntityException;
import entities.exceptions.NotIsDeletableEntityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import cell.Type;
import java.sql.Statement;
import persistence.ConnectionFactory;
import persistence.Entity;
import persistence.querygen.QueryGenerator;
import persistence.querygen.SimpleQueryGenerator;

/**
 *
 * @author murilo
 */
public class SimpleQueries implements Queries<Entity> {

    /**
     *
     * @param e
     * @throws NotIsInsertableEntityException
     */
    @Override
    public void insert(Entity e) throws NotIsInsertableEntityException {

        for (int i = 0; i < e.getNumOfColumns(); i++) {
            if (e.getCell(i).isNotNull() && e.getCell(i).getValue().equals(null)) {
                throw new NotIsInsertableEntityException();
            }
        }

        Connection conn = ConnectionFactory.getConnection();
        PreparedStatement stmt = null;
        QueryGenerator qg = new SimpleQueryGenerator();

        try {
            stmt = conn.prepareStatement(qg.insertGenerator(e));
            for (int i = 1; i <= e.getNumOfColumns(); i++) {
                if (e.getCell(0).isIterable()) {
                    if (e.getCell(i).getType().equals(Type.NUM)) {
                        stmt.setInt(i, (Integer) e.getCell(i).getValue());
                    } else {
                        stmt.setString(i, String.valueOf(e.getCell(i).getValue()));
                    }
                } else if (e.getCell(i - 1).getType().equals(Type.NUM)) {
                    stmt.setInt(i, (Integer) e.getCell(i - 1).getValue());
                } else {
                    stmt.setString(i, String.valueOf(e.getCell(i - 1).getValue()));
                }
            }
            stmt.executeUpdate();
            stmt.close();
            conn.close();
        } catch (SQLException | ArrayIndexOutOfBoundsException er) {
            System.out.println(er);
        }
    }

    /**
     *
     * @param e
     * @throws NotIsDeletableEntityException
     */
    @Override
    public void delete(Entity e) throws NotIsDeletableEntityException {
        if (e.getCell(0).getValue().equals(null)) {
            throw new NotIsDeletableEntityException();
        }

        Connection conn = ConnectionFactory.getConnection();
        Statement stmt = null;
        QueryGenerator qg = new SimpleQueryGenerator();

        try {
            stmt = conn.createStatement();
            stmt.executeUpdate(qg.deleteGenerator(e));
            stmt.close();
            conn.close();
        } catch (SQLException er) {
            System.out.println(er);
        }
    }

    /**
     *
     * @param e
     * @throws NotIsUpgradeableEntityException
     */
    @Override
    public void update(Entity e) throws NotIsUpgradeableEntityException {
        if (!e.getCell(0).isIterable() && e.getCell(0).getValue().equals(null)) {
            throw new NotIsUpgradeableEntityException();
        }

        Connection conn = ConnectionFactory.getConnection();
        PreparedStatement stmt = null;
        QueryGenerator qg = new SimpleQueryGenerator();

        try {
            stmt = conn.prepareStatement(qg.updateGenerator(e));
            for (int i = 1; i <= e.getNumOfColumns(); i++) {
                if (e.getCell(0).isIterable()) {
                    if (e.getCell(i).getType().equals(Type.NUM)) {
                        stmt.setInt(i, (Integer) e.getCell(i).getValue());
                    } else {
                        stmt.setString(i, String.valueOf(e.getCell(i).getValue()));
                    }
                } else if (e.getCell(i - 1).getType().equals(Type.NUM)) {
                    stmt.setInt(i, (Integer) e.getCell(i - 1).getValue());
                } else {
                    stmt.setString(i, String.valueOf(e.getCell(i - 1).getValue()));
                }
            }
            stmt.executeUpdate();
        } catch (SQLException | ArrayIndexOutOfBoundsException er) {
            System.out.println(er);
        }
    }

    public void select(int id, Entity...e) throws NotIsSelectableEntityException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void select(Entity e) throws NotIsSelectableEntityException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Entity especificallySelect(int ID) throws NotIsSelectableEntityException {
        return null;
    }
}
