--
-- TODO: decimal(10, 1)
--
alter table sd_zv_kitas_schulkreis alter column anz_bp_sk      decimal(6, 1) not null;
alter table sd_zv_kitas_schulkreis alter column anz_kinder_va  decimal(6, 1) not null;
alter table kita_reconstructed     alter column anz_kinder_va  decimal(6, 1) not null;

alter table sd_zv_kitas_schulkreis alter column anz_bp_sk      float         not null;
alter table sd_zv_kitas_schulkreis alter column anz_kinder_va  float         not null;
alter table kita_reconstructed     alter column anz_kinder_va  float         not null;
