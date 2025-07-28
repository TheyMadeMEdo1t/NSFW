

### 🛠️ General `pfctl` Commands

* Disable packet-filtering:

  ```
  pfctl -d
  ```
* Enable packet-filtering:

  ```
  pfctl -e
  ```
* Run quietly (suppress non-critical output):

  ```
  pfctl -q
  ```
* More verbose output:

  ```
  pfctl -v
  ```
* Even more verbose (twice verbose):

  ```
  pfctl -v -v
  ```

---

### 📂 Loading PF Rules

* Load rules from `/etc/pf.conf`:

  ```
  pfctl -f /etc/pf.conf
  ```
* Parse (test) rules without loading:

  ```
  pfctl -n -f /etc/pf.conf
  ```
* Load only FILTER rules:

  ```
  pfctl -R -f /etc/pf.conf
  ```
* Load only NAT rules:

  ```
  pfctl -N -f /etc/pf.conf
  ```
* Load only OPTION rules:

  ```
  pfctl -O -f /etc/pf.conf
  ```

---

### 🧹 Clearing PF Rules & Counters

*(Note: flushing rules does not affect existing stateful connections)*

* Flush **all** rules, NAT, queue, stats:

  ```
  pfctl -F all
  ```
* Flush just **rules**:

  ```
  pfctl -F rules
  ```
* Flush just **queue** entries:

  ```
  pfctl -F queue
  ```
* Flush just **NAT** rules:

  ```
  pfctl -F nat
  ```
* Flush statistic info:

  ```
  pfctl -F info
  ```
* **Zero** all rule counters:

  ```
  pfctl -z
  ```

---

### 📈 Output PF Information

* Show filter rules:

  ```
  pfctl -s rules
  ```

  or

  ```
  pfctl -sr
  ```
* Show filter rules **with hits** (with verbosity):

  ```
  pfctl -v -s rules
  ```
* Show filter rules with rule numbers and hits:

  ```
  pfctl -vvsr
  ```
* Show NAT rules with hits:

  ```
  pfctl -v -s nat
  ```
* Show NAT info for a specific interface (e.g. `xl1`):

  ```
  pfctl -s nat -i xl1
  ```
* Show queue information:

  ```
  pfctl -s queue
  ```
* Show label info:

  ```
  pfctl -s label
  ```
* Show contents of the state table:

  ```
  pfctl -s state
  ```
* Show stats on state tables and packet normalization:

  ```
  pfctl -s info
  ```
* Show **everything**:

  ```
  pfctl -s all
  ```

---

### 📋 Maintaining PF Tables

* Show contents of `addvhosts` table:

  ```
  pfctl -t addvhosts -T show
  ```
* View verbose info on all tables:

  ```
  pfctl -vvsTables
  ```
* **Add** an address to the table:

  ```
  pfctl -t addvhosts -T add 192.168.0.5
  ```
* Add a **network** to the table:

  ```
  pfctl -t addvhosts -T add 192.168.0.0/16
  ```
* **Delete** a network from the table:

  ```
  pfctl -t addvhosts -T delete 192.168.0.0/16
  ```
* **Flush** all entries in the table:

  ```
  pfctl -t addvhosts -T flush
  ```
* **Kill** (delete) the table itself:

  ```
  pfctl -t addvhosts -T kill
  ```
* **Replace** table contents from a file:

  ```
  pfctl -t addvhosts -T replace -f /etc/addvhosts
  ```
* **Test** if an address is in the table:

  ```
  pfctl -t addvhosts -T test 192.168.0.140
  ```
* **Load** a new table definition:

  ```
  pfctl -T load -f /etc/pf.conf
  ```
* Show per-IP stats in the table:

  ```
  pfctl -t addvhosts -T show -vi
  ```
* **Zero** (reset) table counters:

  ```
  pfctl -t addvhosts -T zero
  ```

---

That covers the complete `pfctl` cheat‑sheet from the handbook. Let me know if you'd like details or examples for any command!

[1]: https://www.openbsdhandbook.com/pf/cheat_sheet/?utm_source=chatgpt.com "pfctl cheat sheet - OpenBSD Handbook"
