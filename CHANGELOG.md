### 0.2.0

* additions
  * Add dinamic association for Profiles throuh Entity id and class attriutes;
  * Add find methods to collect all Profiles without Entity and with specific entity;
  * Update all views and controllers with the new attriutes for Profile.

### 0.0.9

* removals
  * Change the necessity to use `session` for `Arpa::Additions::Resource`.
  * Change the necessity to pass `session` as parameter on initialize for `Arpa::Services::Verifier`.
  * Remove from `session` to store all user permissions.
