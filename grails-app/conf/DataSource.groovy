dataSource {
    pooled = true
    driverClassName = "com.mysql.jdbc.Driver"
    username = "root"
    password = "zhwell"
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory'
}
// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "create-drop" // one of 'create', 'create-drop', 'update', 'validate', ''
            //url = "jdbc:h2:mem:devDb;MVCC=TRUE;LOCK_TIMEOUT=10000"
            url = "jdbc:mysql://localhost/sri.score?useUnicode=true&amp;characterEncoding=UTF8 "
        }
    }
    test {
        dataSource {
            dbCreate = "validate"
            url = "jdbc:mysql://localhost/sri.score?useUnicode=true&amp;characterEncoding=UTF8 "
        }
    }
    production {
        dataSource {
            dbCreate = "validate"
            url = "jdbc:mysql://localhost/sri.score?useUnicode=true&amp;characterEncoding=UTF8 "
            pooled = true
            properties {
               maxActive = -1
               minEvictableIdleTimeMillis=1800000
               timeBetweenEvictionRunsMillis=1800000
               numTestsPerEvictionRun=3
               testOnBorrow=true
               testWhileIdle=true
               testOnReturn=true
               validationQuery="SELECT 1"
            }
        }
    }
}
