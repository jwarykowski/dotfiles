# Personal machine

- My repos are `jwarykowski/*` on Forgejo (`code.warykowski.io`, primary, CI via Forgejo Actions); Forgejo push-mirrors them to GitHub and Codeberg. GitHub Actions stays off on the mirrors.
- Remotes: fetch over HTTPS (`https://code.warykowski.io/jwarykowski/<repo>.git`), push over SSH (`git@git.warykowski.io:jwarykowski/<repo>.git`, through the Cloudflare tunnel). Manage Forgejo with `fj`.
- `~/dotfiles` is the exception to "never commit on the default branch": it commits straight to `master`.
