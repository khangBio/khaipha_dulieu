package com.csdl.group_one.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;

@Configuration
public class SpringMVCConfiguration {
    @Autowired
    private Environment env;

//    @Bean
//    public DataSource dataSource() throws IllegalArgumentException, NamingException {
//        DriverManagerDataSource ds = new DriverManagerDataSource();
//        ds.setDriverClassName(env.getProperty("spring.datasource.driver-class-name"));
//        ds.setUrl(env.getProperty("spring.datasource.url"));
//        ds.setUsername(env.getProperty("spring.datasource.username"));
//        ds.setPassword(env.getProperty("spring.datasource.password"));
//        return ds;
//    }

//    @Bean
//    public NamedParameterJdbcTemplate namedParameterJdbcTemplate(DataSource dataSource) throws NamingException {
//        return new NamedParameterJdbcTemplate(dataSource());
//    }

//    @Bean
//    public TilesConfigurer tilesConfigurer() {
//        TilesConfigurer tilesConfigurer = new TilesConfigurer();
//        tilesConfigurer.setDefinitions("/WEB-INF/tiles/tiles.xml");
//        tilesConfigurer.setCheckRefresh(true);
//        return tilesConfigurer;
//    }
//
//    @Bean
//    public ViewResolver viewResolver() {
//        UrlBasedViewResolver viewResolver = new UrlBasedViewResolver();
//        viewResolver.setViewClass(TilesView.class);
//        return viewResolver;
//    }

}
