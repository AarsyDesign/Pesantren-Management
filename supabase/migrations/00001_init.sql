-- Pesantren Management — Initial Database Schema
-- All tables use UUID PKs, TIMESTAMPTZ, tenant_id for multi-tenant RLS.

-- ============================================================
-- 1. MASTER DATA
-- ============================================================

CREATE TABLE mst_tenant (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  kode VARCHAR(20) UNIQUE NOT NULL,
  nama VARCHAR(200) NOT NULL,
  slug VARCHAR(100) UNIQUE NOT NULL,
  alamat TEXT,
  kota VARCHAR(100),
  provinsi VARCHAR(100),
  telepon VARCHAR(20),
  email VARCHAR(100),
  logo_url TEXT,
  status VARCHAR(20) NOT NULL DEFAULT 'aktif' CHECK (status IN ('aktif', 'nonaktif')),
  is_deleted BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE mst_tenant_setting (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES mst_tenant(id),
  format_invoice VARCHAR(50) NOT NULL DEFAULT '{TENANT}-{TAHUN}-{BULAN}-{SEQ}',
  billing_periode VARCHAR(20) NOT NULL DEFAULT 'bulanan' CHECK (billing_periode IN ('bulanan', 'tahunan', 'kustom')),
  cicilan_aktif BOOLEAN NOT NULL DEFAULT FALSE,
  cicilan_maksimal INTEGER NOT NULL DEFAULT 12 CHECK (cicilan_maksimal >= 1),
  zona_waktu VARCHAR(50) NOT NULL DEFAULT 'Asia/Jakarta',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(tenant_id)
);

-- User management
CREATE TABLE mst_role (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nama VARCHAR(50) UNIQUE NOT NULL,
  deskripsi TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

INSERT INTO mst_role (nama, deskripsi) VALUES
  ('super_admin', 'Super admin — akses semua tenant'),
  ('admin', 'Admin TU — kelola master data'),
  ('bendahara', 'Bendahara — kelola keuangan'),
  ('pimpinan', 'Pimpinan — lihat laporan');

CREATE TABLE mst_pengguna (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID REFERENCES mst_tenant(id), -- NULL for super_admin
  auth_user_id UUID UNIQUE NOT NULL,        -- FK to auth.users (Supabase Auth)
  nama VARCHAR(200) NOT NULL,
  email VARCHAR(100) NOT NULL,
  telepon VARCHAR(20),
  avatar_url TEXT,
  is_deleted BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE mst_pengguna_role (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  pengguna_id UUID NOT NULL REFERENCES mst_pengguna(id) ON DELETE CASCADE,
  role_id UUID NOT NULL REFERENCES mst_role(id),
  tenant_id UUID NOT NULL REFERENCES mst_tenant(id),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(pengguna_id, role_id, tenant_id)
);

-- Academic
CREATE TABLE mst_tahun_ajaran (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES mst_tenant(id),
  nama VARCHAR(50) NOT NULL,
  tanggal_mulai DATE NOT NULL,
  tanggal_selesai DATE NOT NULL,
  is_aktif BOOLEAN NOT NULL DEFAULT FALSE,
  is_deleted BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  -- Only one active per tenant
  UNIQUE(tenant_id, nama)
);

CREATE TABLE mst_kelas (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES mst_tenant(id),
  tahun_ajaran_id UUID NOT NULL REFERENCES mst_tahun_ajaran(id),
  nama VARCHAR(50) NOT NULL,
  tingkat INTEGER,
  wali_kelas VARCHAR(200),
  is_deleted BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE mst_santri (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES mst_tenant(id),
  nis VARCHAR(20) NOT NULL,
  nama VARCHAR(200) NOT NULL,
  tanggal_lahir DATE,
  jenis_kelamin VARCHAR(10) CHECK (jenis_kelamin IN ('laki', 'perempuan')),
  alamat TEXT,
  telepon VARCHAR(20),
  status VARCHAR(20) NOT NULL DEFAULT 'aktif' CHECK (status IN ('aktif', 'nonaktif', 'alumni')),
  is_deleted BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(tenant_id, nis)
);

CREATE TABLE mst_wali (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES mst_tenant(id),
  nama VARCHAR(200) NOT NULL,
  telepon VARCHAR(20),
  email VARCHAR(100),
  alamat TEXT,
  is_deleted BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE mst_santri_wali (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES mst_tenant(id),
  santri_id UUID NOT NULL REFERENCES mst_santri(id) ON DELETE CASCADE,
  wali_id UUID NOT NULL REFERENCES mst_wali(id) ON DELETE CASCADE,
  hubungan VARCHAR(50), -- ayah, ibu, dll
  is_utama BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(santri_id, wali_id)
);

CREATE TABLE mst_santri_kelas (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES mst_tenant(id),
  santri_id UUID NOT NULL REFERENCES mst_santri(id) ON DELETE CASCADE,
  kelas_id UUID NOT NULL REFERENCES mst_kelas(id),
  tahun_ajaran_id UUID NOT NULL REFERENCES mst_tahun_ajaran(id),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(santri_id, tahun_ajaran_id)
);

-- Financial master data
CREATE TABLE mst_produk_kategori (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES mst_tenant(id),
  nama VARCHAR(100) NOT NULL,
  deskripsi TEXT,
  is_deleted BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE mst_produk_keuangan (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES mst_tenant(id),
  kategori_id UUID REFERENCES mst_produk_kategori(id),
  nama VARCHAR(200) NOT NULL,
  deskripsi TEXT,
  nominal_default BIGINT NOT NULL CHECK (nominal_default >= 0),
  tipe VARCHAR(20) NOT NULL DEFAULT 'bulanan' CHECK (tipe IN ('bulanan', 'sekali', 'kustom')),
  is_deleted BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE mst_rekening_bank (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES mst_tenant(id),
  nama_bank VARCHAR(100) NOT NULL,
  nomor_rekening VARCHAR(30) NOT NULL,
  nama_pemilik VARCHAR(200) NOT NULL,
  is_aktif BOOLEAN NOT NULL DEFAULT TRUE,
  is_deleted BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE mst_kas (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES mst_tenant(id),
  nama VARCHAR(100) NOT NULL,
  deskripsi TEXT,
  saldo_awal BIGINT NOT NULL DEFAULT 0,
  is_aktif BOOLEAN NOT NULL DEFAULT TRUE,
  is_deleted BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- 2. TRANSAKSI KEUANGAN
-- ============================================================

-- Billing packages
CREATE TABLE keu_paket_tagihan (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES mst_tenant(id),
  tahun_ajaran_id UUID NOT NULL REFERENCES mst_tahun_ajaran(id),
  nama VARCHAR(200) NOT NULL,
  target VARCHAR(20) NOT NULL DEFAULT 'semua' CHECK (target IN ('semua', 'kelas', 'individu')),
  periode_mulai DATE NOT NULL,
  periode_selesai DATE NOT NULL,
  is_aktif BOOLEAN NOT NULL DEFAULT TRUE,
  is_deleted BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE keu_paket_detail (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES mst_tenant(id),
  paket_id UUID NOT NULL REFERENCES keu_paket_tagihan(id) ON DELETE CASCADE,
  produk_id UUID NOT NULL REFERENCES mst_produk_keuangan(id),
  nominal_override BIGINT CHECK (nominal_override IS NULL OR nominal_override >= 0),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE keu_paket_santri (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES mst_tenant(id),
  paket_id UUID NOT NULL REFERENCES keu_paket_tagihan(id) ON DELETE CASCADE,
  santri_id UUID NOT NULL REFERENCES mst_santri(id) ON DELETE CASCADE,
  kelas_id UUID REFERENCES mst_kelas(id), -- NULL when target='individu'
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(paket_id, santri_id)
);

-- Invoices (immutable after creation)
CREATE TABLE keu_invoice (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES mst_tenant(id),
  santri_id UUID NOT NULL REFERENCES mst_santri(id),
  paket_id UUID NOT NULL REFERENCES keu_paket_tagihan(id),
  nomor VARCHAR(50) NOT NULL,
  periode_bulan INTEGER NOT NULL CHECK (periode_bulan BETWEEN 1 AND 12),
  periode_tahun INTEGER NOT NULL CHECK (periode_tahun BETWEEN 2000 AND 2100),
  total BIGINT NOT NULL DEFAULT 0 CHECK (total >= 0),
  status VARCHAR(20) NOT NULL DEFAULT 'belum_bayar'
    CHECK (status IN ('belum_bayar', 'sebagian', 'lunas')),
  is_void BOOLEAN NOT NULL DEFAULT FALSE,
  void_alasan TEXT,
  void_by UUID,
  void_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  -- No duplicate invoice per santri per paket per period
  UNIQUE(tenant_id, santri_id, paket_id, periode_bulan, periode_tahun)
  -- partial unique where is_void = false — enforced via trigger or application logic
);

-- Invoice detail (snapshot at creation time — immutable)
CREATE TABLE keu_invoice_detail (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES mst_tenant(id),
  invoice_id UUID NOT NULL REFERENCES keu_invoice(id) ON DELETE CASCADE,
  produk_id UUID NOT NULL,
  nama_produk VARCHAR(200) NOT NULL,  -- snapshot nama at creation
  nominal BIGINT NOT NULL CHECK (nominal >= 0),  -- snapshot nominal at creation
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Payments
CREATE TABLE keu_pembayaran (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES mst_tenant(id),
  invoice_id UUID NOT NULL REFERENCES keu_invoice(id),
  santri_id UUID NOT NULL REFERENCES mst_santri(id),
  nominal BIGINT NOT NULL CHECK (nominal > 0),
  metode VARCHAR(20) NOT NULL CHECK (metode IN ('cash', 'transfer', 'qris')),
  reference VARCHAR(100), -- bukti/notes
  kas_id UUID REFERENCES mst_kas(id),
  is_void BOOLEAN NOT NULL DEFAULT FALSE,
  void_alasan TEXT,
  void_by UUID,
  void_at TIMESTAMPTZ,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Cash book entries
CREATE TABLE keu_buku_kas (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES mst_tenant(id),
  kas_id UUID NOT NULL REFERENCES mst_kas(id),
  tanggal TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  keterangan TEXT NOT NULL,
  debet BIGINT NOT NULL DEFAULT 0 CHECK (debet >= 0),
  kredit BIGINT NOT NULL DEFAULT 0 CHECK (kredit >= 0),
  tipe VARCHAR(20) NOT NULL CHECK (tipe IN ('otomatis', 'manual')),
  reference_id UUID,  -- points to keu_pembayaran.id if otomatis
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tutup kas
CREATE TABLE keu_tutup_kas (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES mst_tenant(id),
  kas_id UUID NOT NULL REFERENCES mst_kas(id),
  periode_bulan INTEGER NOT NULL CHECK (periode_bulan BETWEEN 1 AND 12),
  periode_tahun INTEGER NOT NULL,
  saldo_awal BIGINT NOT NULL,
  total_pemasukan BIGINT NOT NULL DEFAULT 0,
  total_pengeluaran BIGINT NOT NULL DEFAULT 0,
  saldo_akhir BIGINT NOT NULL,
  selisih BIGINT NOT NULL DEFAULT 0,
  status VARCHAR(20) NOT NULL DEFAULT 'dibuka' CHECK (status IN ('dibuka', 'tertutup')),
  closed_by UUID,
  closed_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(tenant_id, kas_id, periode_bulan, periode_tahun)
);

-- ============================================================
-- 3. LOG & AUDIT
-- ============================================================

CREATE TABLE log_audit (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES mst_tenant(id),
  user_id UUID,
  action VARCHAR(10) NOT NULL CHECK (action IN ('INSERT', 'UPDATE', 'VOID')),
  table_name VARCHAR(100) NOT NULL,
  record_id UUID NOT NULL,
  data_lama JSONB,
  data_baru JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE log_billing_engine (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES mst_tenant(id),
  tahun_ajaran_id UUID,
  triggered_by VARCHAR(20) NOT NULL CHECK (triggered_by IN ('otomatis', 'manual')),
  invoices_created INTEGER NOT NULL DEFAULT 0,
  errors INTEGER NOT NULL DEFAULT 0,
  duration_ms INTEGER,
  error_messages JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- 4. ROW LEVEL SECURITY
-- ============================================================

ALTER TABLE mst_tenant ENABLE ROW LEVEL SECURITY;
ALTER TABLE mst_tenant_setting ENABLE ROW LEVEL SECURITY;
ALTER TABLE mst_pengguna ENABLE ROW LEVEL SECURITY;
ALTER TABLE mst_pengguna_role ENABLE ROW LEVEL SECURITY;
ALTER TABLE mst_tahun_ajaran ENABLE ROW LEVEL SECURITY;
ALTER TABLE mst_kelas ENABLE ROW LEVEL SECURITY;
ALTER TABLE mst_santri ENABLE ROW LEVEL SECURITY;
ALTER TABLE mst_wali ENABLE ROW LEVEL SECURITY;
ALTER TABLE mst_santri_wali ENABLE ROW LEVEL SECURITY;
ALTER TABLE mst_santri_kelas ENABLE ROW LEVEL SECURITY;
ALTER TABLE mst_produk_kategori ENABLE ROW LEVEL SECURITY;
ALTER TABLE mst_produk_keuangan ENABLE ROW LEVEL SECURITY;
ALTER TABLE mst_rekening_bank ENABLE ROW LEVEL SECURITY;
ALTER TABLE mst_kas ENABLE ROW LEVEL SECURITY;
ALTER TABLE keu_paket_tagihan ENABLE ROW LEVEL SECURITY;
ALTER TABLE keu_paket_detail ENABLE ROW LEVEL SECURITY;
ALTER TABLE keu_paket_santri ENABLE ROW LEVEL SECURITY;
ALTER TABLE keu_invoice ENABLE ROW LEVEL SECURITY;
ALTER TABLE keu_invoice_detail ENABLE ROW LEVEL SECURITY;
ALTER TABLE keu_pembayaran ENABLE ROW LEVEL SECURITY;
ALTER TABLE keu_buku_kas ENABLE ROW LEVEL SECURITY;
ALTER TABLE keu_tutup_kas ENABLE ROW LEVEL SECURITY;
ALTER TABLE log_audit ENABLE ROW LEVEL SECURITY;
ALTER TABLE log_billing_engine ENABLE ROW LEVEL SECURITY;

-- Helper: get tenant_id from JWT
CREATE OR REPLACE FUNCTION auth.tenant_id()
RETURNS UUID AS $$
  SELECT NULLIF(current_setting('request.jwt.claims', true)::json->>'tenant_id', '')::uuid;
$$ LANGUAGE sql STABLE SECURITY DEFINER;

-- Default policy: tenant isolation
-- User can only see rows where tenant_id matches their JWT tenant_id

CREATE POLICY tenant_isolation ON mst_tenant
  FOR ALL USING (
    auth.tenant_id() IS NULL  -- super_admin: no tenant_id
    OR id = auth.tenant_id()
  );

CREATE POLICY tenant_isolation ON mst_tenant_setting
  FOR ALL USING (tenant_id = auth.tenant_id());

CREATE POLICY tenant_isolation ON mst_pengguna
  FOR ALL USING (
    auth.tenant_id() IS NULL
    OR tenant_id = auth.tenant_id()
  );

CREATE POLICY tenant_isolation ON mst_pengguna_role
  FOR ALL USING (tenant_id = auth.tenant_id());

CREATE POLICY tenant_isolation ON mst_tahun_ajaran
  FOR ALL USING (tenant_id = auth.tenant_id());

CREATE POLICY tenant_isolation ON mst_kelas
  FOR ALL USING (tenant_id = auth.tenant_id());

CREATE POLICY tenant_isolation ON mst_santri
  FOR ALL USING (tenant_id = auth.tenant_id());

CREATE POLICY tenant_isolation ON mst_wali
  FOR ALL USING (tenant_id = auth.tenant_id());

CREATE POLICY tenant_isolation ON mst_santri_wali
  FOR ALL USING (tenant_id = auth.tenant_id());

CREATE POLICY tenant_isolation ON mst_santri_kelas
  FOR ALL USING (tenant_id = auth.tenant_id());

CREATE POLICY tenant_isolation ON mst_produk_kategori
  FOR ALL USING (tenant_id = auth.tenant_id());

CREATE POLICY tenant_isolation ON mst_produk_keuangan
  FOR ALL USING (tenant_id = auth.tenant_id());

CREATE POLICY tenant_isolation ON mst_rekening_bank
  FOR ALL USING (tenant_id = auth.tenant_id());

CREATE POLICY tenant_isolation ON mst_kas
  FOR ALL USING (tenant_id = auth.tenant_id());

CREATE POLICY tenant_isolation ON keu_paket_tagihan
  FOR ALL USING (tenant_id = auth.tenant_id());

CREATE POLICY tenant_isolation ON keu_paket_detail
  FOR ALL USING (tenant_id = auth.tenant_id());

CREATE POLICY tenant_isolation ON keu_paket_santri
  FOR ALL USING (tenant_id = auth.tenant_id());

CREATE POLICY tenant_isolation ON keu_invoice
  FOR ALL USING (tenant_id = auth.tenant_id());

CREATE POLICY tenant_isolation ON keu_invoice_detail
  FOR ALL USING (tenant_id = auth.tenant_id());

CREATE POLICY tenant_isolation ON keu_pembayaran
  FOR ALL USING (tenant_id = auth.tenant_id());

CREATE POLICY tenant_isolation ON keu_buku_kas
  FOR ALL USING (tenant_id = auth.tenant_id());

CREATE POLICY tenant_isolation ON keu_tutup_kas
  FOR ALL USING (tenant_id = auth.tenant_id());

CREATE POLICY tenant_isolation ON log_audit
  FOR ALL USING (tenant_id = auth.tenant_id());

CREATE POLICY tenant_isolation ON log_billing_engine
  FOR ALL USING (tenant_id = auth.tenant_id());

-- ============================================================
-- 5. INDEXES (performance)
-- ============================================================

CREATE INDEX idx_santri_tenant ON mst_santri(tenant_id);
CREATE INDEX idx_santri_nis ON mst_santri(tenant_id, nis);
CREATE INDEX idx_santri_status ON mst_santri(tenant_id, status);

CREATE INDEX idx_kelas_tenant ON mst_kelas(tenant_id);
CREATE INDEX idx_kelas_ta ON mst_kelas(tenant_id, tahun_ajaran_id);

CREATE INDEX idx_invoice_tenant ON keu_invoice(tenant_id);
CREATE INDEX idx_invoice_santri ON keu_invoice(tenant_id, santri_id);
CREATE INDEX idx_invoice_status ON keu_invoice(tenant_id, status);
CREATE INDEX idx_invoice_periode ON keu_invoice(tenant_id, periode_bulan, periode_tahun);
CREATE INDEX idx_invoice_paket ON keu_invoice(tenant_id, paket_id);

CREATE INDEX idx_pembayaran_tenant ON keu_pembayaran(tenant_id);
CREATE INDEX idx_pembayaran_invoice ON keu_pembayaran(tenant_id, invoice_id);
CREATE INDEX idx_pembayaran_date ON keu_pembayaran(tenant_id, created_at);

CREATE INDEX idx_bukukas_tenant ON keu_buku_kas(tenant_id);
CREATE INDEX idx_bukukas_kas ON keu_buku_kas(tenant_id, kas_id);
CREATE INDEX idx_bukukas_date ON keu_buku_kas(tenant_id, tanggal);

CREATE INDEX idx_tutupkas_tenant ON keu_tutup_kas(tenant_id);
CREATE INDEX idx_audit_tenant ON log_audit(tenant_id);
CREATE INDEX idx_audit_record ON log_audit(tenant_id, table_name, record_id);
