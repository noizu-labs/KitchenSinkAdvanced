#-------------------------------------------------------------------------------
# Author: Keith Brings
# Copyright (C) 2020 Noizu Labs, Inc. All rights reserved.
#-------------------------------------------------------------------------------

defprotocol Noizu.V3.Proto.EmailServiceTemplate do
  def refresh!(template, context)
  def bind_template(template, transactional_email, context, options \\ nil)
end # end defprotocol
