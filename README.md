Chef Cookbooks
==============

A set of cookbooks to use Chef for managing configuration for Django on Ubuntu
servers. These cookbooks are designed to be used to handle everything except
for the deployment, which can be handled with a separate tool like Fabric. In
the future, these cookbooks will likely be updated to take advantage of Chef's
*deploy* resource to manage the checkout of the code as well.

Read the documentation [here][1].

## Inspiration

Many of these cookbooks came from the [Opscode repository][2], but
they have been heavily modified.  Some of the ideas came from Eric Holscher's
great [blog posts][3] about using Chef with Django.  The node.js cookbook was
stripped down (a lot) from [Digital Butter's][4] version.

[1]: http://lincolnloop.github.com/chef-cookbooks/
[2]: http://github.com/opscode/cookbooks
[3]: http://ericholscher.com/blog/2010/nov/8/building-django-app-server-chef/
[4]: https://github.com/digitalbutter/cookbook-node/
