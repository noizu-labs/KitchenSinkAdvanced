#-------------------------------------------------------------------------------
# Author: Keith Brings
# Copyright (C) 2020 Noizu Labs, Inc. All rights reserved.
#-------------------------------------------------------------------------------

defmodule Noizu.Cms.V2.ProtoProvider do
  #----------------------
  #
  #----------------------
  def tags(ref, _context, _options) do
    ref.article_info.tags
  end

  def tags!(ref, _context, _options) do
    ref.article_info.tags
  end

  #----------------------
  #
  #----------------------
  def type(ref, _context, _options) do
    ref.__struct__.cms_type()
  end

  def type!(ref, _context, _options) do
    ref.__struct__.cms_type()
  end


  #----------------------
  #
  #----------------------
  def is_cms_entity?(_ref, _context, _options), do: true
  def is_cms_entity!(_ref, _context, _options), do: true

  #----------------------
  #
  #----------------------
  def is_versioning_record?(ref, context, options) do
    ref.__struct__.is_versioning_record?(ref, context, options)
  end

  def is_versioning_record!(ref, context, options) do
    ref.__struct__.is_versioning_record!(ref, context, options)
  end

  #----------------------
  #
  #----------------------
  def is_revision_record?(ref, context, options) do
    ref.__struct__.is_revision_record?(ref, context, options)
  end

  def is_revision_record!(ref, context, options) do
    ref.__struct__.is_revision_record!(ref, context, options)
  end


  #----------------------
  #
  #----------------------
  def versioned_identifier(ref, _context, _options) do
    if ref.article_info && ref.article_info.revision do
      # @Hack - Avoid Hard Coded Formatting, need prototypes, etc. here.
      {:ref, _, {{:ref, _v, {_article, version_path}}, revision_number}} = Noizu.ERP.ref(ref.article_info.revision)
      case ref.identifier do
        # @Hack - Avoid Hard Coded Formatting, need prototypes, etc. here.
        {:revision, {identifier, _version, _revision}} -> {:revision, {identifier, version_path, revision_number}}
        identifier -> {:revision, {identifier, version_path, revision_number}}
      end
    end
  end

  def versioned_identifier!(ref, context, options) do
    versioned_identifier(ref, context, options)
  end

  #----------------------
  #
  #----------------------
  def article_identifier(ref, _context, _options) do
    case ref.identifier do
      # @Hack - Avoid Hard Coded Formatting, need prototypes, etc. here.
      {:revision, {identifier, _version, _revision}} -> identifier
      identifier -> identifier
    end
  end
  def article_identifier!(ref, context, options) do
    article_identifier(ref, context, options)
  end

  def versioned_ref(ref, _context, _options) do
    if ref.article_info && ref.article_info.revision do
      # @Hack - Avoid Hard Coded Formatting, need prototypes, etc. here.
      {:ref, _, {{:ref, _v, {{:ref, _a, identifier}, version_path}}, revision_number}} = Noizu.ERP.ref(ref.article_info.revision)
      Noizu.ERP.ref(%{ref| identifier: {:revision, {identifier, version_path, revision_number}}})
    end
  end

  def versioned_ref!(ref, context, options) do
    versioned_ref(ref, context, options)
  end

  def article_ref(ref, _context, _options) do
    case ref.identifier do
      # @Hack - Avoid Hard Coded Formatting, need prototypes, etc. here.
      {:revision, {identifier, _version, _revision}} -> Noizu.ERP.ref(%{ref| identifier: identifier})
      _identifier -> Noizu.ERP.ref(ref)
    end
  end

  def article_ref!(ref, context, options) do
    article_ref(ref, context, options)
  end

  #----------------------
  #
  #----------------------
  def compress_archive(ref, context, options) do
    {:ref, Noizu.Cms.V2.Proto.versioned_ref(ref, context, options)}
  end

  def compress_archive!(ref, context, options) do
    {:ref, Noizu.Cms.V2.Proto.versioned_ref!(ref, context, options)}
  end

  #----------------------
  #
  #----------------------
  def get_article(ref, _context, _options), do: ref

  def get_article!(ref, _context, _options), do: ref

  #----------------------
  #
  #----------------------
  def set_version(ref, version, _context, _options) do
    put_in(ref, [Access.key(:article_info), Access.key(:version)], Noizu.Cms.V2.VersionEntity.ref(version))
  end

  def set_version!(ref, version, context, options) do
    set_version(ref, version, context, options)
  end

  #----------------------
  #
  #----------------------
  def get_version(ref, _context, _options) do
    ref.article_info && ref.article_info.version
  end

  def get_version!(ref, context, options) do
    get_version(ref, context, options)
  end

  #----------------------
  #
  #----------------------
  def set_revision(ref, revision, _context, _options) do
    put_in(ref, [Access.key(:article_info), Access.key(:revision)], Noizu.Cms.V2.Version.RevisionEntity.ref(revision))
  end

  def set_revision!(ref, revision, context, options) do
    set_revision(ref, revision, context, options)
  end

  #----------------------
  #
  #----------------------
  def get_revision(ref, _context, _options) do
    ref.article_info && ref.article_info.revision
  end

  def get_revision!(ref, context, options) do
    get_revision(ref, context, options)
  end

  #----------------------
  #
  #----------------------
  def set_parent(ref, version, _context, _options) do
    put_in(ref, [Access.key(:article_info), Access.key(:parent)], Noizu.Cms.V2.VersionEntity.ref(version))
  end

  def set_parent!(ref, version, context, options) do
    set_parent(ref, version, context, options)
  end
  #----------------------
  #
  #----------------------
  def get_parent(ref, _context, _options) do
    ref.article_info && ref.article_info.parent
  end

  def get_parent!(ref, context, options) do
    get_parent(ref, context, options)
  end

  #----------------------
  #
  #----------------------
  def get_article_info(ref, _context, _options) do
    get_in(ref, [Access.key(:article_info)])
  end

  def get_article_info!(ref, _context, _options) do
    get_in(ref, [Access.key(:article_info)])
  end


  #--------------------------------
  # @init_article_info
  #--------------------------------
  def init_article_info(entity, context, options) do
    entity.__struct__.article_info_entity().init(entity, context, options)
  end

  def init_article_info!(entity, context, options) do
    entity.__struct__.article_info_entity().init!(entity, context, options)
  end

  #--------------------------------
  # @update_article_info
  #--------------------------------
  def update_article_info(entity, context, options) do
    entity.__struct__.article_info_entity().update(entity, context, options)
  end

  def update_article_info!(entity, context, options) do
    entity.__struct__.article_info_entity().update!(entity, context, options)
  end

  #----------------------
  #
  #----------------------
  def set_article_info(ref, article_info, _context, _options) do
    put_in(ref, [Access.key(:article_info)], article_info)
  end

  def set_article_info!(ref, article_info, _context, _options) do
    put_in(ref, [Access.key(:article_info)], article_info)
  end
end