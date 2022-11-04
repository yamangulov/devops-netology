#!/usr/bin/python

# Copyright: (c) 2018, Terry Jones <terry.jones@example.org>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)
from __future__ import (absolute_import, division, print_function)
__metaclass__ = type
import os

DOCUMENTATION = r'''
---
module: my_test

short_description: This is my test module

# If this is part of a collection, you need to use semantic versioning,
# i.e. the version is of the form "2.5.0" and not "2.4".
version_added: "1.0.0"

description: This is my test module for netology devOps learning course.

options:
    path:
        description: path to new file.
        required: true
        type: str
    content:
        description: content written to file
        required: true
        type: str
# Specify this value according to your collection
# in format of namespace.collection.doc_fragment_name
extends_documentation_fragment:
    - my_namespace.my_collection.my_test_module

author:
    - Andrey Iamangulov (@yamangulov)
'''

EXAMPLES = r'''
# Pass in a message
- name: write a file
  my_namespace.my_collection.my_test_module:
    path: '/tmp/file.txt'
    content: 'File is written by module my_namespace.my_collection.my_test_module'
'''

RETURN = r'''
# These are examples of possible return values, and in general should use other names for return values.
original_message:
    description: Content written.
    type: str
    returned: always
    sample: 'File is written by module my_namespace.my_collection.my_test_module'
message:
    description: The output message that the test module generates.
    type: str
    returned: always
    sample: 'File was written from module my_namespace.my_collection.my_test_module'
'''

from ansible.module_utils.basic import AnsibleModule


def run_module():
    # define available arguments/parameters a user can pass to the module
    module_args = dict(
        path=dict(type='str', required=True),
        content=dict(type='str', required=True)
    )

    # seed the result dict in the object
    # we primarily care about changed and state
    # changed is if this module effectively modified the target
    # state will include any data that you want your module to pass back
    # for consumption, for example, in a subsequent task
    result = dict(
        changed=False,
        original_message='',
        message=''
    )

    # the AnsibleModule object will be our abstraction working with Ansible
    # this includes instantiation, a couple of common attr would be the
    # args/params passed to the execution, as well as if the module
    # supports check mode
    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=True
    )

    # if the user is working with this module in only check mode we do not
    # want to make any changes to the environment, just return the current
    # state with no modifications
    if module.check_mode:
        module.exit_json(**result)

    # manipulate or modify the state as needed (this is going to be the
    # part where your module will do what it needs to do)
    if not os.path.exists(module.params['path']):
        fl = open(module.params['path'],"w")
        fl.write(module.params['content'])
        fl.close()
        result['changed'] = True
        result['message'] = 'File was written from module my_namespace.my_collection.my_test_module successfully'
    else:
        result['changed'] = False
        result['message'] = 'File is already exists on that path'
    result['original_message'] = module.params['content']

    # in the event of a successful module execution, you will want to
    # simple AnsibleModule.exit_json(), passing the key/value results
    module.exit_json(**result)


def main():
    run_module()


if __name__ == '__main__':
    main()