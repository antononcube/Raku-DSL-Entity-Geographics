# DSL::Entity::Geographics

Raku grammar classes for geographic entities (names.)

## Installation

From [Zef ecosystem](https://raku.land):

```
zef install DSL::Entity::Geographics
```

From GitHub:

```
zef install https://github.com/antononcube/Raku-DSL-Entity-Geographics.git
```

## Examples

### 

```perl6
use DSL::Entity::Geographics;

ToGeographicEntityCode('Brazilian');
```

### Grammar parsing

```perl6
use DSL::Entity::Geographics::Grammar;

my $pCOMMAND = DSL::Entity::Geographics::Grammar.new;

$pCOMMAND.set-resources(DSL::Entity::Geographics::resource-access-object());

say $pCOMMAND.parse('Argentina', rule => 'geographic-entity-command');
```

```perl6
say $pCOMMAND.parse('United States of America', rule => 'geographic-entity-command');
```

## References

[AAr1] Anton Antonov,
[DSL::Shared Raku package](https://github.com/antononcube/Raku-DSL-Shared),
(2020),
[GitHub/antononcube](https://github.com/antononcube).

[AAr2] Anton Antonov,
[DSL::Entity::Jobs Raku package](https://github.com/antononcube/Raku-DSL-Entity-Jobs),
(2021),
[GitHub/antononcube](https://github.com/antononcube).

[AAr3] Anton Antonov,
[DSL::Entity::Foods Raku package](https://github.com/antononcube/Raku-DSL-Entity-Foods),
(2021),
[GitHub/antononcube](https://github.com/antononcube).
