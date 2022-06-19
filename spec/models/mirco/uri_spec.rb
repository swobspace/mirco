# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mirco::Uri, type: :model do
  subject { Mirco::Uri.new(url) }

  describe "with tcp://0.0.0.0:12345" do
    let(:url) { "tcp://0.0.0.0:12345" }

    it { expect(subject.scheme).to eq("tcp") }
    it { expect(subject.host).to eq("0.0.0.0") }
    it { expect(subject.port).to eq(12345) }
    it { expect(subject.path).to eq("") }
  end

  describe "with tcp://11.22.33.44:5555" do
    let(:url) { "tcp://11.22.33.44:5555" }
    it { expect(subject.scheme).to eq("tcp") }
    it { expect(subject.host).to eq("11.22.33.44") }
    it { expect(subject.port).to eq(5555) }
    it { expect(subject.path).to eq("") }
  end

  describe "with tcp://11.22.33.44:5555/whatever/mypath" do
    let(:url) { "tcp://11.22.33.44:5555/whatever/mypath" }
    it { expect(subject.scheme).to eq("tcp") }
    it { expect(subject.host).to eq("11.22.33.44") }
    it { expect(subject.port).to eq(5555) }
    it { expect(subject.path).to eq("/whatever/mypath") }
  end


  describe"with FILE://D:/Mirth Connect/transfer/HiMed7_Entlassungen_nach_Himed/*.DD" do
    let(:url) { 'FILE://D:/Mirth Connect/transfer/HiMed7_Entlassungen_nach_Himed/*.DD'}
    it { expect(subject.scheme).to eq("file") }
    it { expect(subject.host).to eq("D:") }
    it { expect(subject.port).to be_nil }
    it { expect(subject.path).to eq("/Mirth Connect/transfer/HiMed7_Entlassungen_nach_Himed/*.DD") }
  end

  describe "with FILE://${PUBDATA}/paisy/*" do
    let(:url) { 'FILE://${PUBDATA}/paisy/*' }
    it { expect(subject.scheme).to eq("file") }
    it { expect(subject.host).to eq("${PUBDATA}") }
    it { expect(subject.port).to be_nil }
    it { expect(subject.path).to eq("/paisy/*") }
  end

  describe "with FILE://${PUBDATA}/knirps/kodierung/*.dat" do
    let(:url) { 'FILE://${PUBDATA}/knirps/kodierung/*.dat' }
    it { expect(subject.scheme).to eq("file") }
    it { expect(subject.host).to eq("${PUBDATA}") }
    it { expect(subject.port).to be_nil }
    it { expect(subject.path).to eq("/knirps/kodierung/*.dat") }
  end

  describe "with SMB://10.200.146.19/sap_nrh$/NTHL7.dat" do
    let(:url) { 'SMB://10.200.146.19/sap_nrh$/NTHL7.dat' }
    it { expect(subject.scheme).to eq("smb") }
    it { expect(subject.host).to eq("10.200.146.19") }
    it { expect(subject.port).to be_nil }
    it { expect(subject.path).to eq("/sap_nrh$/NTHL7.dat") }
  end

  describe "with FILE:///srv/mirth/data/resend/*.resend" do
    let(:url) { 'FILE:///srv/mirth/data/resend/*.resend' }
    it { expect(subject.scheme).to eq("file") }
    it { expect(subject.host).to eq("") }
    it { expect(subject.port).to be_nil }
    it { expect(subject.path).to eq("/srv/mirth/data/resend/*.resend") }
  end

  describe "with FILE://${PATH_IFMSPathoPro2ORBIS}/*.DAT" do
    let(:url) { 'FILE://${PATH_IFMSPathoPro2ORBIS}/*.DAT' }
    it { expect(subject.scheme).to eq("file") }
    it { expect(subject.host).to eq("${PATH_IFMSPathoPro2ORBIS}") }
    it { expect(subject.port).to be_nil }
    it { expect(subject.path).to eq("/*.DAT") }
  end

  describe "with SMB://kkm-file1.kkmainz.local/iXServe-BArzt$/*.hl7" do
    let(:url) { 'SMB://kkm-file1.kkmainz.local/iXServe-BArzt$/*.hl7' }
    it { expect(subject.scheme).to eq("smb") }
    it { expect(subject.host).to eq("kkm-file1.kkmainz.local") }
    it { expect(subject.port).to be_nil }
    it { expect(subject.path).to eq("/iXServe-BArzt$/*.hl7") }
  end

  describe "FILE://D:/reimport_adt/*.HL7" do
    let(:url) { 'FILE://D:/reimport_adt/*.HL7' }
    it { expect(subject.scheme).to eq("file") }
    it { expect(subject.host).to eq("D:") }
    it { expect(subject.port).to be_nil }
    it { expect(subject.path).to eq("/reimport_adt/*.HL7") }
  end

  describe "SMB://kkm-mmi.kkmainz.local/MMI-Orbis-Austausch/*" do
    let(:url) { 'SMB://kkm-mmi.kkmainz.local/MMI-Orbis-Austausch/*' }
    it { expect(subject.scheme).to eq("smb") }
    it { expect(subject.host).to eq("kkm-mmi.kkmainz.local") }
    it { expect(subject.port).to be_nil }
    it { expect(subject.path).to eq("/MMI-Orbis-Austausch/*") }
  end

  describe "FILE://${DATADIR}/archiv/${archDir}/dft/DFT-${date.get('yyyyMMdd')}.log" do
    let(:url) { "FILE://${DATADIR}/archiv/${archDir}/dft/DFT-${date.get('yyyyMMdd')}.log" }
    it { expect(subject.scheme).to eq("file") }
    it { expect(subject.host).to eq("${DATADIR}") }
    it { expect(subject.port).to be_nil }
    it { expect(subject.path).to eq("/archiv/${archDir}/dft/DFT-${date.get('yyyyMMdd')}.log") }
  end

  describe "FTP://192.2.131.201//adt_orbis_${message.messageId}.hl7" do
    let(:url) { 'FTP://192.2.131.201//adt_orbis_${message.messageId}.hl7' }
    it { expect(subject.scheme).to eq("ftp") }
    it { expect(subject.host).to eq("192.2.131.201") }
    it { expect(subject.port).to be_nil }
    it { expect(subject.path).to eq("//adt_orbis_${message.messageId}.hl7") }
  end

  describe "FILE://D:/Mirth Connect/transfer/HL7_MDM_OPUSL_OUT/${filename}" do
    let(:url) { 'FILE://D:/Mirth Connect/transfer/HL7_MDM_OPUSL_OUT/${filename}' }
    it { expect(subject.scheme).to eq("file") }
    it { expect(subject.host).to eq("D:") }
    it { expect(subject.port).to be_nil }
    it { expect(subject.path).to eq("/Mirth Connect/transfer/HL7_MDM_OPUSL_OUT/${filename}") }
  end

  describe "set uri components" do
    it "#to_s delivers url with port" do
      uri = Mirco::Uri.new("tcp://0.0.0.0:1234")
      uri.host = '2.3.4.5'
      expect(uri.to_s).to eq('tcp://2.3.4.5:1234')
    end

    it "#to_s delivers url without port" do
      uri = Mirco::Uri.new("file://0.0.0.0/mypath")
      uri.host = '2.3.4.5'
      expect(uri.to_s).to eq('file://2.3.4.5/mypath')
    end
  end


end
