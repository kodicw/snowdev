{ pkgs, lib, namespace, ... }:
pkgs.writeShellApplication {
  name = "ceph-setup";
  text = ''
    export IP=<your-node-IP-on-local-LAN>
    export FSID=4b687c5c-5a20-4a77-8774-487989fd0bc7

    # Make your paths!
    sudo -u ceph mkdir -p /etc/ceph
    sudo -u ceph mkdir -p /var/lib/ceph/bootstrap-osd
    sudo -u ceph mkdir -p /tmp/monmap
    sudo -u ceph mkdir -p /var/lib/ceph/mon/ceph-$(hostname)
    sudo -u ceph mkdir /var/lib/ceph/mon/ceph-mon-$(hostname)

    # Make a keyring!
    sudo ceph-authtool --create-keyring /etc/ceph/ceph.client.admin.keyring --gen-key -n client.admin --cap mon 'allow *' --cap osd 'allow *' --cap mds 'allow *' --cap mgr 'allow *'
    sudo mkdir -p /var/lib/ceph/bootstrap-osd && sudo ceph-authtool --create-keyring /var/lib/ceph/bootstrap-osd/ceph.keyring --gen-key -n client.bootstrap-osd --cap mon 'profile bootstrap-osd' --cap mgr 'allow r'
    sudo ceph-authtool /tmp/ceph.mon.keyring --import-keyring /etc/ceph/ceph.client.admin.keyring sudo ceph-authtool /tmp/ceph.mon.keyring --import-keyring /var/lib/ceph/bootstrap-osd/ceph.keyring
    sudo chown ceph:ceph /tmp/ceph.mon.keyring

    # Make a monitor!
    sudo monmaptool --create --add mesh-a $IP --fsid $FSID /tmp/monmap
    sudo -u ceph ceph-mon --mkfs -i mon-$(hostname) --monmap /tmp/monmap --keyring /tmp/ceph.mon.keyring
  '';
}

