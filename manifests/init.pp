# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include elk
class elk {
  class {'logstash':}
  logstash::plugin {'logstash-input-beats':}
  logstash::configfile{'beats':
    source => 'puppet:///modules/elk/beats.conf',
  }


  include ::java                            #Since Elasticsearch depends on Java
  class { 'elasticsearch':  
    jvm_options => ['-Xms256m','-Xmx256m']  #Configuring memory to be small for demo  
  }
  elasticsearch::instance { 'es-01': }      #Defining the instance

  class {'kibana': 
    config => {
      'server.host' => '0.0.0.0'            #To make is accessible from all networks
    }
  }
}
}
