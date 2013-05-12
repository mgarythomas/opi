package org.opi.cfg;

import java.net.URI;

import javax.sql.DataSource;

import org.apache.commons.dbcp.BasicDataSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.core.env.Environment;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

@Configuration
@Profile("heroku")
@PropertySource(name = "spo", value = "classpath:/jdbc.properties")
public class SpoHerokuConfiguration {

	final private Logger logger = LoggerFactory
			.getLogger(SpoJNDIConfiguration.class);

	@Autowired
	Environment env;

	@Bean(name = "dataSource")
	DataSource getDataSource() throws Exception {
		URI databaseURL = new URI(env.getProperty("DATABASE_URL"));

		logger.debug("HEROKU Retrieving Data Source : "
				+ databaseURL.toString());
		BasicDataSource ds = new BasicDataSource();

		ds.setDriverClassName("org.postgresql.Driver");
		ds.setUrl("jdbc:postgresql://" + databaseURL.getHost() + ":"
				+ databaseURL.getPort() + databaseURL.getPath());
		logger.debug("HEROKU URL: " + databaseURL.getHost() + ":"
				+ databaseURL.getPort() + databaseURL.getPath());
		ds.setUsername("");
		if (databaseURL.getUserInfo().split(":").length > 0) {
			ds.setUsername(databaseURL.getUserInfo().split(":")[0]);
			logger.debug("HEROKU Username : "+ds.getUsername());
		}
		ds.setPassword("");
		if (databaseURL.getUserInfo().split(":").length > 1) {
			ds.setPassword(databaseURL.getUserInfo().split(":")[1]);
			logger.debug("HEROKU PS : "+ds.getPassword());
		}
		return ds;
	}

	/**
	 * This method is a bit of a hack, but, it is better on balance to have it
	 * here. This adds a <code>PlaceholderConfigurer</code> to the Application
	 * Context. This is allows the property values to be resolved.
	 * 
	 * @return
	 */
	@Bean
	public static PropertySourcesPlaceholderConfigurer properties() {

		PropertySourcesPlaceholderConfigurer pspc = new PropertySourcesPlaceholderConfigurer();
		Resource[] resources = new ClassPathResource[]

		{ new ClassPathResource("jdbc.properties") };
		pspc.setLocations(resources);
		pspc.setIgnoreUnresolvablePlaceholders(true);
		return pspc;

	}

}
