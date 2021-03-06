require "spec_helper" 

describe Permission do
  describe "as guest" do
    let(:permission) { Permission.new(nil) }
    subject { Permission.new(nil) } 

    it "allowha some actions" do 
      permission.should allowha("topics", "index") 
    end
    it { should_not allowha("topics", "new") }
    it { should_not allowha("topics", "create") }
    it { should_not allowha("topics", "edit") }
    it { should_not allowha("topics", "update") }
    it { should_not allowha("topics", "destroy") }

    it { should allowha("sessions", "new") }
    it { should allowha("sessions", "create") }
    it { should allowha("sessions", "destroy") }

    it { should allowha("users", "new") }
    it { should allowha("users", "create") }
    it { should_not allowha("users", "edit") }
    it { should_not allowha("users", "update") }
  end

  describe "as admin" do
    subject { Permission.new(build(:user, admin: true)) }

    it { should allowha("anything", "here") }
  end

  describe "as member" do
    subject { Permission.new(build(:user, admin: false)) }

    it { should allowha("topics", "index") }
    it { should allowha("topics", "show") }
    it { should allowha("topics", "new") }
    it { should allowha("topics", "create") }
    it { should allowha("topics", "edit") }
    it { should allowha("topics", "update") }
    it { should_not allowha("topics", "destroy") }

    it { should allowha("sessions", "new") }
    it { should allowha("sessions", "create") }
    it { should allowha("sessions", "destroy") }

    it { should allowha("users", "new") }
    it { should allowha("users", "create") }
    it { should allowha("users", "edit") }
    it { should allowha("users", "update") }
  end
end
