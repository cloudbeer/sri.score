dataSource {
    pooled = true
    driverClassName = "com.mysql.jdbc.Driver"
//    username = "jifen"
//    password = "jifen!123"
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
            dbCreate = "" // one of 'create', 'create-drop', 'update', 'validate', ''
            //正式服务器
//            url = "jdbc:mysql://42.121.119.89/jifen?useUnicode=true&amp;characterEncoding=UTF8"
//            username = "jifen"
//            password = "jifen!123"
            //测试服务器
            //url = "jdbc:mysql://42.121.120.91/jifen?useUnicode=true&amp;characterEncoding=UTF8"
            //username = "jifen"
//            password = "1234567890"
            //本地服务器
            url = "jdbc:mysql://localhost/sri.score?useUnicode=true&amp;characterEncoding=UTF8"
            username = "root"
            password = "zhwell"
        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:mysql://localhost/sri.point?useUnicode=true&amp;characterEncoding=UTF8"
        }
    }
    production {
        dataSource {
            dbCreate = ""
            //url = "jdbc:mysql://42.121.120.91/jifen?useUnicode=true&amp;characterEncoding=UTF8"
            //正式服务器
            url = "jdbc:mysql://42.121.119.89/jifen?useUnicode=true&amp;characterEncoding=UTF8"
            username = "jifen"
            password = "jifen!123"
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
