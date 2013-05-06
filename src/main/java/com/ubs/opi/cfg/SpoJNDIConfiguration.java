package com.ubs.opi.cfg;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.core.env.Environment;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

@Configuration
@Profile("jndi")
@PropertySource(name = "spo", value = "classpath:/jdbc.properties")
public class SpoJNDIConfiguration {

	final private Logger logger = LoggerFactory
			.getLogger(SpoJNDIConfiguration.class);
	
	@Autowired
	private Environment env;

	@Value("${jdbc.url}")
	private String jdbcUrl;
	
	@Value("${jdbc.username}")
	private String jdbcUsername;
	
	@Value("${jdbc.password}")
	private String jdbcPassword;

	@Value("${jdbc.jndi.name}")
	private String jndiName;
	
	@Bean(name="dataSource")
	DataSource getDataSource() throws NamingException {
		logger.debug("Getting JNDI Name from "+getJndiName());
		Context ctx = new InitialContext();
        return (DataSource) ctx.lookup(getJndiName());
	}
	
	/**
	 * This method is a bit of a hack, but, it is better on balance to have it here.
	 * This adds a <code>PlaceholderConfigurer</code> to the Application Context.
	 * This is allows the property values to be resolved.
	 * @return
	 */
	@Bean
	public static PropertySourcesPlaceholderConfigurer properties() {

		PropertySourcesPlaceholderConfigurer pspc =	new PropertySourcesPlaceholderConfigurer();
		Resource[] resources = new ClassPathResource[]

		{ new ClassPathResource("jdbc.properties") };
		pspc.setLocations(resources);
		pspc.setIgnoreUnresolvablePlaceholders(true);
		return pspc;

	}
	
	public Logger getLogger() {
		return logger;
	}

	public Environment getEnv() {
		return env;
	}

	public String getJndiName() {
		logger.debug("JNDI Name: "+jndiName);
		return jndiName;
	}

	public String getJdbcUrl() {
		logger.debug("JDBC URL: "+jdbcUrl);
		return jdbcUrl;
	}

	public String getJdbcUsername() {
		logger.debug("JDBC User: "+jdbcUsername);
		return jdbcUsername;
	}

	public String getJdbcPassword() {
		return jdbcPassword;
	}

}
