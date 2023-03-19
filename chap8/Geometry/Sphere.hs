module Geometry.Sphere
(
    volume
)where

volume :: Float -> Float
volume radius = (4.0 / 3.0) * pi * (radius ^3)