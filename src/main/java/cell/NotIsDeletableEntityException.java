/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cell;

import entity.*;

/**
 *
 * @author murilo
 */
public class NotIsDeletableEntityException extends RuntimeException {
    public NotIsDeletableEntityException(Entity e) {
        super("Nao e possivel deletetar esta entidade. Por favor, verifique seus valores.");
    }
}
