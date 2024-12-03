## Prototype Pollution

#### Exploitation

- Vulnerable NodeJS libraries: [here](https://raw.githubusercontent.com/HoLyVieR/prototype-pollution-nsec18/master/paper/JavaScript_prototype_pollution_attack_in_NodeJS.pdf)
- Access prototype of an object via `__proto__` or `constructor.prototype` property
- Client-side prototype pollution vulnerabilities: [here](https://github.com/BlackFan/client-side-prototype-pollution)
- Safe Identification: [here](https://portswigger.net/research/server-side-prototype-pollution)
	- Status Code: `__proto__.status`
	- Parameter Limit: `__proto__.parameterLimit`
	- Content-Type: `__proto__.content-type`

### Attack can be chained with XSS, DoS, etc

#### Prevention

- Check user-supplied properties against a whitelist
- Freeze prototype by calling `Object.freeze()`
- Create object without prototype with `Object.create(null)`
