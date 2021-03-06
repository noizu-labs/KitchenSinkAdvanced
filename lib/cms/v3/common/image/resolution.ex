#-------------------------------------------------------------------------------
# Author: Keith Brings
# Copyright (C) 2021 Noizu Labs, Inc. All rights reserved.
#-------------------------------------------------------------------------------

defmodule Noizu.V3.CMS.Article.Image.Resolution do
  @vsn 1.0

  @type t :: %__MODULE__{
               dimensions: {integer, integer} | nil,
               dpi: integer | nil,
               file: String.t | nil,
               size: integer | nil,
               vsn: float
             }

  defstruct [
    dimensions: nil,
    dpi: nil,
    file: nil,
    size: nil,
    vsn: @vsn
  ]
end # end defmodule
