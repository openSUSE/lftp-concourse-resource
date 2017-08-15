# LFTP Resource

A Concourse CI resource to interface with lftp.
It can check any URL lftp understands and download files. Version checking is done listing the directory at `url` and applying a glob to find versions.


## Source Configuration

* `url`: URL of the remote server, directory listing must be enabled.
* `regexp`: The pattern to match filenames against within the servers directory listing. Only `(.*)` is supported. It's only supported once and gets translated to `([0-9.-]*)`.

## Example

```
resource_types:
- name: lftp-resource
  type: docker-image
  source:
      repository: machinerytool/concourse-lftp-resource
      tag: latest

resources:
- name: fresh-kernel
  type: lftp-resource
  source:
    url: http://download.opensuse.org/tumbleweed/repo/oss/suse/x86_64/
    regexp: kernel-default-(.*).x86_64.rpm

jobs:
- name: install-package
  plan:
  - get: fresh-kernel
  - task: work
    config:
      run:
        path: rpm
        args: [-i, "*rpm"]
        directory: fresh-kernel
```

## Behaviour

### `check`: Check for new revisions

Checks the remote server for versions.

### `in`: Fetch from build service

Downloads from remote server.

### `out`: Build and/or Commit to build service

Might actually upload, try to provide credentials in the `url` parameter.

#### Parameters

* `files`: Required. Glob of files to be uploaded.

#### Example

```
    - put: ftp-resource
      params:
        files: "output/*.tgz"
```
