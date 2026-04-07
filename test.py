def test_os(host):
    assert host.system_info.distribution == "alpine"

def test_nginx_installed(host):
    nginx = host.package("nginx")
    assert nginx.is_installed

def test_nginx_version(host):
    cmd = host.run("nginx -v")
    assert "nginx version" in cmd.stderr
