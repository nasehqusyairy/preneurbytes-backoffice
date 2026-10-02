CREATE TABLE "public"."article_tag" (
  "article_id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "tag_id"     uuid NOT NULL DEFAULT gen_random_uuid(),
  "tenant_id"  uuid DEFAULT gen_random_uuid(),
  CONSTRAINT "article_tag_pkey" PRIMARY KEY (article_id, tag_id)
);

ALTER TABLE "public"."article_tag"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."articles" (
  "id"           uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "tenant_id"    uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "slug"         text,
  "title"        text,
  "author"       text,
  "cover"        text,
  "content"      text,
  "is_published" boolean,
  "created_at"   timestamp with time zone,
  "update_at"    timestamp with time zone,
  "deleted_at"   timestamp with time zone,
  CONSTRAINT "articles_pkey" PRIMARY KEY (id)
);

ALTER TABLE "public"."articles"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."discounts" (
  "id"           uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "tenant_id"    uuid                     NOT NULL,
  "title"        character varying,
  "value"        numeric,
  "max_discount" numeric,
  "min_purchase" numeric,
  "start_at"     timestamp with time zone,
  "end_at"       timestamp with time zone,
  "created_at"   timestamp with time zone,
  "update_at"    timestamp with time zone,
  "deleted_at"   timestamp with time zone,
  CONSTRAINT "discounts_pkey" PRIMARY KEY (id)
);

ALTER TABLE "public"."discounts"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."photos" (
  "id"          uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "tenant_id"   uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "src"         text                     NOT NULL,
  "title"       text                     NOT NULL,
  "description" text,
  "created_at"  timestamp with time zone NOT NULL DEFAULT now(),
  "updated_at"  timestamp with time zone NOT NULL DEFAULT now(),
  "deleted_at"  timestamp with time zone,
  CONSTRAINT "photos_pkey" PRIMARY KEY (id)
);

ALTER TABLE "public"."photos"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."product_dicsount" (
  "id"          uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "tenant_id"   uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "product_id"  uuid                     DEFAULT gen_random_uuid(),
  "discount_id" uuid                     DEFAULT gen_random_uuid(),
  "created_at"  timestamp with time zone,
  CONSTRAINT "product_dicsount_pkey" PRIMARY KEY (id)
);

ALTER TABLE "public"."product_dicsount"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."product_tags" (
  "product_id" uuid NOT NULL,
  "tag_id"     uuid NOT NULL,
  "tenant_id"  uuid NOT NULL,
  CONSTRAINT "product_tags_pkey" PRIMARY KEY (product_id, tag_id)
);

ALTER TABLE "public"."product_tags"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."products" (
  "id"          uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "tenant_id"   uuid                     NOT NULL,
  "title"       character varying        NOT NULL,
  "description" text                     NOT NULL,
  "price"       numeric                  NOT NULL,
  "stock"       integer                  NOT NULL DEFAULT 0,
  "img"         text                     NOT NULL,
  "created_at"  timestamp with time zone NOT NULL DEFAULT now(),
  "updated_at"  timestamp with time zone NOT NULL DEFAULT now(),
  "deleted_at"  timestamp with time zone,
  CONSTRAINT "products_pkey" PRIMARY KEY (id)
);

ALTER TABLE "public"."products"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."tags" (
  "id"        uuid NOT NULL DEFAULT gen_random_uuid(),
  "tenant_id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "name"      text,
  CONSTRAINT "tags_name_key" UNIQUE (name),
  CONSTRAINT "tags_pkey" PRIMARY KEY (id)
);

ALTER TABLE "public"."tags"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."tenants" (
  "id"         uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "name"       text                     NOT NULL,
  "slug"       text,
  "created_at" timestamp with time zone,
  "update_at"  timestamp with time zone,
  "deleted_at" timestamp with time zone,
  CONSTRAINT "tenants_pkey" PRIMARY KEY (id),
  CONSTRAINT "tenants_slug_key" UNIQUE (slug)
);

ALTER TABLE "public"."tenants"
  ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."article_tag"
  ADD CONSTRAINT "article_tag_article_id_fkey" FOREIGN KEY (article_id) REFERENCES public.articles(id);

ALTER TABLE "public"."product_dicsount"
  ADD CONSTRAINT "product_dicsount_discount_id_fkey" FOREIGN KEY (discount_id) REFERENCES public.discounts(id);

ALTER TABLE "public"."product_tags"
  ADD CONSTRAINT "product_tags_product_id_fkey" FOREIGN KEY (product_id) REFERENCES public.products(id);

ALTER TABLE "public"."article_tag"
  ADD CONSTRAINT "article_tag_article_id_fkey1" FOREIGN KEY (article_id) REFERENCES public.tags(id);

ALTER TABLE "public"."product_tags"
  ADD CONSTRAINT "product_tags_tag_id_fkey" FOREIGN KEY (tag_id) REFERENCES public.tags(id);

ALTER TABLE "public"."article_tag"
  ADD CONSTRAINT "article_tag_tenant_id_fkey" FOREIGN KEY (tenant_id) REFERENCES public.tenants(id);

ALTER TABLE "public"."articles"
  ADD CONSTRAINT "articles_tenant_id_fkey" FOREIGN KEY (tenant_id) REFERENCES public.tenants(id);

ALTER TABLE "public"."discounts"
  ADD CONSTRAINT "discounts_tenant_id_fkey" FOREIGN KEY (tenant_id) REFERENCES public.tenants(id);

ALTER TABLE "public"."photos"
  ADD CONSTRAINT "photos_tenant_id_fkey" FOREIGN KEY (tenant_id) REFERENCES public.tenants(id);

ALTER TABLE "public"."product_dicsount"
  ADD CONSTRAINT "product_dicsount_tenant_id_fkey" FOREIGN KEY (tenant_id) REFERENCES public.tenants(id);

ALTER TABLE "public"."product_tags"
  ADD CONSTRAINT "product_tags_tenant_id_fkey" FOREIGN KEY (tenant_id) REFERENCES public.tenants(id);

ALTER TABLE "public"."products"
  ADD CONSTRAINT "products_tenant_id_fkey" FOREIGN KEY (tenant_id) REFERENCES public.tenants(id);

ALTER TABLE "public"."tags"
  ADD CONSTRAINT "tags_tenant_id_fkey" FOREIGN KEY (tenant_id) REFERENCES public.tenants(id);

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."article_tag" TO "anon", "authenticated", "postgres", "service_role";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."articles" TO "anon", "authenticated", "postgres", "service_role";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."discounts" TO "anon", "authenticated", "postgres", "service_role";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."photos" TO "anon", "authenticated", "postgres", "service_role";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."product_dicsount" TO "anon", "authenticated", "postgres", "service_role";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."product_tags" TO "anon", "authenticated", "postgres", "service_role";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."products" TO "anon", "authenticated", "postgres", "service_role";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."tags" TO "anon", "authenticated", "postgres", "service_role";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."tenants" TO "anon", "authenticated", "postgres", "service_role";

