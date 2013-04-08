package com.ubs.opi.service;

import java.util.List;

import com.ubs.opi.domain.Product;

/**
 * Service layer for dealing with products.
 * 
 * @author Ana Velez
 */
public interface SuperUserServiceIF {
  /**
   * Returns products to display for superusers, which is essentially all 
   * products.
   * 
   * @return All products.
   */
  List<Product> getProductsToDisplayForSuperusers();
}
