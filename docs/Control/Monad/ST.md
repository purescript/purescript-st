## Module Control.Monad.ST

#### `ST`

``` purescript
data ST :: * -> !
```

The `ST` effect represents _local mutation_, i.e. mutation which does not "escape" into the surrounding computation.

An `ST` computation is parameterized by a phantom type which is used to restrict the set of reference cells it is allowed to access.

The `runST` function can be used to handle the `ST` effect.

#### `STRef`

``` purescript
data STRef :: * -> * -> *
```

The type `STRef s a` represents a mutable reference holding a value of type `a`, which can be used with the `ST s` effect.

#### `newSTRef`

``` purescript
newSTRef :: forall a h r. a -> Eff (st :: ST h | r) (STRef h a)
```

Create a new mutable reference.

#### `readSTRef`

``` purescript
readSTRef :: forall a h r. STRef h a -> Eff (st :: ST h | r) a
```

Read the current value of a mutable reference.

#### `modifySTRef`

``` purescript
modifySTRef :: forall a h r. STRef h a -> (a -> a) -> Eff (st :: ST h | r) a
```

Modify the value of a mutable reference by applying a function to the current value.

#### `writeSTRef`

``` purescript
writeSTRef :: forall a h r. STRef h a -> a -> Eff (st :: ST h | r) a
```

Set the value of a mutable reference.

#### `runST`

``` purescript
runST :: forall a r. (forall h. Eff (st :: ST h | r) a) -> Eff r a
```

Run an `ST` computation.

Note: the type of `runST` uses a rank-2 type to constrain the phantom type `s`, such that the computation must not leak any mutable references
to the surrounding computation.

It may cause problems to apply this function using the `$` operator. The recommended approach is to use parentheses instead.

#### `pureST`

``` purescript
pureST :: forall a. (forall h. Eff (st :: ST h) a) -> a
```

A convenience function which combines `runST` with `runPure`, which can be used when the only required effect is `ST`.

Note: since this function has a rank-2 type, it may cause problems to apply this function using the `$` operator. The recommended approach
is to use parentheses instead.


