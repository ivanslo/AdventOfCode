
a good function to use was 'scanl'

scanl :: (b -> a -> b) -> b -> [a] -> [b]
	scanl is similar to foldl, but returns a list of successive reduced values from the left:
	scanl f z [x1, x2, ...] == [z, z `f` x1, (z `f` x1) `f` x2, ...]
