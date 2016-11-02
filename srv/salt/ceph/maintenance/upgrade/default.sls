{% for host in salt.saltutil.runner('select.minions', cluster='ceph') %}

   
    wait for {{ host }} to unblock the cluster:
      salt.state:
        - tgt: {{ salt['pillar.get']('master_minion') }}
        - sls: ceph.wait

    upgrading {{ host }}:
      salt.state:
        - tgt: {{ host }}
        - tgt_type: compound
        - sls: ceph.upgrade
        - failhard: True

{% endfor %}
