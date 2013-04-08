package com.ubs.opi.domain;

import java.util.Comparator;

public class AdvisorproviderComp implements Comparator<Advisorprovider>,java.io.Serializable {

	public int compare(Advisorprovider o1, Advisorprovider o2) {
		return (o1.getAdvisor().getIndividual().getFullname()).compareToIgnoreCase(o2.getAdvisor().getIndividual().getFullname());
	}
}
