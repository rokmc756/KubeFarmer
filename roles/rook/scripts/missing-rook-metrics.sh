#!/bin/bash

set -euo pipefail

# Enable kubectl command
export KUBECONFIG="/etc/rancher/rke2/rke2.yaml"
export PATH="$PATH:/var/lib/rancher/rke2/bin"

function clearCephMgrAlert() {
    local ceph_status
    local active_ceph_mgr

    # Check the curernt rook-ceph cluster status
    ceph_status=$(kubectl -n rook-ceph exec deploy/rook-ceph-tools -- ceph status --format json-pretty | jq -r '.health.status')
    if [[ "${ceph_status}" != "HEALTH_OK" ]]; then
        echo "Error: Your rook-ceph cluster is not healthy. Please review your environment."
        return 1
    fi
    active_ceph_mgr=$(kubectl -n rook-ceph exec deploy/rook-ceph-tools -- ceph mgr dump | jq -r '.active_name')
    if [[ "${active_ceph_mgr}" != "a" ]]; then
        echo "Curently your active rook-ceph-mgr is ${active_ceph_mgr}. Failing over to to the standby mgr a to fix CephMgrIsAbsent alert."
        kubectl -n rook-ceph exec deploy/rook-ceph-tools -- ceph mgr fail ${active_ceph_mgr}
        if [[ $? -ne 0 ]]; then
            echo "Error: Failed to failover to the standby mgr a. Please manually check your ceph status."
            return 1
        fi
    fi
    echo "Your active ceph-mgr should be failed over to a. Please wait for several minutes and ensure CephMgrIsAbsent alert is cleared."
    return 0
}

clearCephMgrAlert
