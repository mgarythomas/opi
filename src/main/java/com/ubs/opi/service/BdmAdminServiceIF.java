package com.ubs.opi.service;

import java.util.Collection;
import java.util.List;

import com.ubs.opi.domain.Advisorprovider;
import com.ubs.opi.domain.Company;
import com.ubs.opi.domain.Individual;

/**
 * 
 * Service layer for BDM admins.
 * 
 * @author Ana Velez
 */
public interface BdmAdminServiceIF {

  /**
   * Finds the provider (company) associated to the given BDM admin user.
   *  
   * @param username BDM Admin username.
   * 
   * @return The provider company the given BDM Admin user is working for.
   */
  Company findProviderForBdmAdmin(String username);

  /**
   * Finds BDMs working under the given provider.
   * 
   * @param provider The provider company.
   * 
   * @return The provider company's BDMs.
   */
  List<Individual> findBdmsForProvider(Company provider);

  /**
   * Updates the BDM associationships to the advisors.
   * 
   * @param advisorProviders The advisorprovider relationships.
   */
  void updateBdmRelationshipsForProvider(Collection<Advisorprovider> advisorProviders);

}
