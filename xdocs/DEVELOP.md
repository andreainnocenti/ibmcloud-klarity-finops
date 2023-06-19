# Developer Notes

## Creating a new release

The creation of a new release follows the flow

1. Make all your changes and test them.
1. Bump the version number in [ibm_catalog.json](../ibm_catalog.json).
1. Commit and push all changes.
1. Create a new release in GitHub or locally with the [GitHub CLI](https://cli.github.com/), matching the new version change:
   ```sh
   gh release create v`cat ibm_catalog.json | jq -r '.products[] | .version'` --notes ""
   ```

## Building the Terraform diagram

The [Terraform diagram in SVG](./graph-v1.1.0.svg) was created with a commands `terraform graph` and `dot -Tsvg`. Manual edits can be done to the `terraform graph` output to remove uninteresting links reduce clutter.

```sh
terraform graph | dot -Tsvg > ./graph-v<version>.svg
```

![Diagram of Terraform configuration for this Deployable Architecture; version 1.1.0](./graph-v1.1.0.svg)
