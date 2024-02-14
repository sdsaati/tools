var exclude = ["*numberia.com",
    "*.ir",
    "*digikala*",
    "*iran*",
];
function FindProxyForURL(url, host) 
{ 
	/* If the requested website is hosted within the internal network, send direct. */
	if (isPlainHostName(host) || shExpMatch(host, "*.local") || 
			isInNet(dnsResolve(host), "192.168.0.0", "255.255.0.0") || 
			isInNet(dnsResolve(host), "127.0.0.0", "255.255.255.0")
	   )
	{
		return "DIRECT"; 
	}

	for (var i = 0; i < exclude.length; i++)
	{
		if (shExpMatch(host, exclude[i]))
		{
			return "DIRECT";
		}
	}

	/* DEFAULT RULE  in fail-over order. */
	return "SOCKS5 127.0.0.1:20170; SOCKS5 127.0.0.1:8080; SOCKS5 127.0.0.1:9150";
}

