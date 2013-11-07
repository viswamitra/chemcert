require 'spec_helper'

describe TrainingOrganizationsController do

  describe "GET #index" do
    it "populates rtos in an array" do
      rto1 = FactoryGirl.create(:training_organization)
      get :index
      assigns(:rtos).should eq([rto1])
    end
    #it "renders the :index view"
  end

  describe "GET #show" do
    it "fetches the requested rto to @rto"
    it "renders the :show view"
  end

  describe "GET #new" do
    it "assigns a new rto to @rto"
    it "renders the :new view"
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new rto into the database"
      it "redirects to the index page of rto"
    end

    context "with invalid attributes" do
      it "does not save rto in the databse"
      it "re-renders the new template"
    end
  end


end
