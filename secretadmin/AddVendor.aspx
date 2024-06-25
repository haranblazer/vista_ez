<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" AutoEventWireup="true" CodeFile="AddVendor.aspx.cs" Inherits="secretadmin_AddVendor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   <style>
    .nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active {
    color: #000;
   /* background-color: #268ddd;*/
    }
    </style>
<h2 class="head">
            <i class="fa fa-exchange" aria-hidden="true"></i> Vendor Registration</h2>

 <section class="main--content">
  <div class="panel panel-default">
  <div class="col-md-12">
                
                     
                           
                            <div class="panel-content">
                            <br />
                                <!-- Form Group Start -->
                                <div class="form-group row">
                                    <span class="label-text col-md-3 col-form-label">Primary Contact</span>
                                    <div class="col-md-2">
                                       <select name="select" class="form-control">
                                            <option value="1">Salutaion</option>
                                            <option value="2">Mr.</option>
                                            <option value="3">Mrs.</option>
                                            <option value="4">Ms.</option>
                                            <option value="5">Miss.</option>
                                            <option value="6">Dr.</option>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <input type="text" name="text" placeholder="First Name" class="form-control">
                                    </div>
                                    <div class="col-md-2">
                                        <input type="text" name="text" placeholder="Last Name" class="form-control">
                                    </div>
                                </div>
                                <!-- Form Group End -->
                                <div class="form-group row">
                                    <span class="label-text col-md-3 col-form-label ">Vendor Display Name</span> 
                                    <div class="col-md-3">
                                        <input type="text" name="text" class="form-control">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <span class="label-text col-md-3 col-form-label ">Primary Contact</span>
                                    <div class="col-md-3">
                                       <select name="select" class="form-control">
                                           <!-- <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>-->
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <span class="label-text col-md-3 col-form-label">Vendor Email</span>
                                    <div class="col-md-3">
                                        <input type="text" name="text" class="form-control">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <span class="label-text col-md-3 col-form-label">Vendor Phone</span>
                                    <div class="col-md-2">
                                        <input type="text" name="text" class="form-control">
                                    </div>
                                    <div class="col-md-2">
                                        <input type="text" name="text" class="form-control">
                                    </div>
                                    <div class="col-md-2">
                                        <a href="#">+ Add more details</a>
                                    </div>
                                </div>
                                <hr />
                            <div class="col-md-12">
                            <ul class="nav nav-tabs nav-tabs-line-top">
                                    <li class="nav-item">
                                        <a href="#tab10" data-toggle="tab" class="nav-link active">Order Details</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#tab11" data-toggle="tab" class="nav-link">Address</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#tab12" data-toggle="tab" class="nav-link">Conatact Person</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#tab13" data-toggle="tab" class="nav-link">Custom Fields</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#tab14" data-toggle="tab" class="nav-link">Reporting Tags</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#tab15" data-toggle="tab" class="nav-link">Remarks</a>
                                    </li>
                            </ul>
                            <div class="tab-content">
                                    <!-- Tab Pane Start -->
                                    <div class="tab-pane fade active" id="tab10">
                                    <br />
                                    <div class="form-group row">
                                    <span class="label-text col-md-2 col-form-label ">GST Treatment</span>
                                    <div class="col-md-3">
                                       <select name="select" class="form-control">
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>                                            
                                       </select>
                                    </div>
                                    </div>
                                    <div class="form-group row">
                                    <span class="label-text col-md-2 col-form-label">Source Of Supply</span>
                                    <div class="col-md-3">
                                       <select name="select" class="form-control">
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>                                            
                                       </select>
                                    </div>
                                    </div>
                                    <div class="form-group row">
                                    <span class="label-text col-md-2 col-form-label">Currency</span>
                                    <div class="col-md-3">
                                       <select name="select" class="form-control">
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>                                            
                                        </select>
                                    </div>  
                                    </div>
                                      <div class="form-group row">
                                    <span class="label-text col-md-2 col-form-label">Opening Balance</span>
                                    <div class="col-md-3">
                                       <select name="select" class="form-control">
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>                                            
                                        </select>
                                    </div>  
                                    </div>
                                      <div class="form-group row">
                                    <span class="label-text col-md-2 col-form-label">Payment Terms</span>
                                    <div class="col-md-3">
                                       <select name="select" class="form-control">
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>                                            
                                        </select>
                                    </div>  
                                    </div>
                                    <div class="form-group row">
                                    <span class="label-text col-md-2 col-form-label">TDS</span>
                                    <div class="col-md-3">
                                       <select name="select" class="form-control">
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>                                            
                                        </select>
                                    </div>  
                                    </div>
                                    <div class="form-group row">
                                    <span class="label-text col-md-2 col-form-label">Facebook</span>
                                    <div class="col-md-3">
                                      <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text" style="color:#44619d;">
                                                    <i class="fa fa-facebook-square"></i>
                                                </span>
                                            </div>
                                            <input type="text" name="text" class="form-control">
                                      </div>
                                    </div>  
                                    </div>
                                    <div class="form-group row">
                                    <span class="label-text col-md-2 col-form-label">twitter</span>
                                    <div class="col-md-3">
                                      <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text" style="color: #00a6ff;">
                                                    <i class="fa fa-twitter-square"></i>
                                                </span>
                                            </div>
                                            <input type="text" name="text" class="form-control">
                                        </div>
                                    </div>  
                                    </div>
                                    </div>
                                  
                                    <div class="tab-pane fade" id="tab11">
                                    <br />
                                    <div class="form-group row">
                                    <span class="label-text col-md-2 col-form-label">Attention</span>
                                    <div class="col-md-3">
                                      <input type="text" name="text" class="form-control">
                                    </div>
                                    <span class="label-text col-md-2 col-form-label text-md-center">Attention</span>
                                    <div class="col-md-3">
                                      <input type="text" name="text" class="form-control">
                                    </div>
                                    </div>
                                    <div class="form-group row">
                                    <span class="label-text col-md-2 col-form-label">Country</span>
                                    <div class="col-md-3">
                                       <select name="select" class="form-control">
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>
                                       </select>
                                    </div>
                                    <span class="label-text col-md-2 col-form-label">Country</span>
                                    <div class="col-md-3">
                                       <select name="select" class="form-control">
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>
                                       </select>
                                    </div>
                                    </div>

                                    <div class="form-group row">
                                    <span class="label-text col-md-2 col-form-label ">Address</span>
                                    <div class="col-md-3">
                                     <textarea name="textarea" class="form-control" placeholder="Street1" spellcheck="false"></textarea>
                                    </div>
                                    <span class="label-text col-md-2 col-form-label">Address</span>
                                    <div class="col-md-3">
                                       <textarea name="textarea" class="form-control" placeholder="Street1" spellcheck="false"></textarea>
                                    </div>
                                    </div>

                                    <div class="form-group row">
                                    <span class="label-text col-md-2 col-form-label"></span>
                                    <div class="col-md-3">
                                     <textarea name="textarea" class="form-control" placeholder="Street2" spellcheck="false"></textarea>
                                    </div>  
                                     <span class="label-text col-md-2 col-form-label text-md-center"></span>
                                    <div class="col-md-3">
                                       <textarea name="textarea" class="form-control" placeholder="Street2" spellcheck="false"></textarea>
                                    </div>  
                                    </div>
                                     <div class="form-group row">
                                    <span class="label-text col-md-2 col-form-label">City</span>
                                    <div class="col-md-3">
                                      <input type="text" name="text" class="form-control">
                                    </div>  
                                     <span class="label-text col-md-2 col-form-label">City</span>
                                    <div class="col-md-3">
                                      <input type="text" name="text" class="form-control">
                                    </div>  
                                    </div> 

                                     <div class="form-group row">
                                    <span class="label-text col-md-2 col-form-label">Zip Code</span>
                                    <div class="col-md-3">
                                      <input type="text" name="text" class="form-control">
                                    </div>  
                                     <span class="label-text col-md-2 col-form-label">Zip Code</span>
                                    <div class="col-md-3">
                                      <input type="text" name="text" class="form-control">
                                    </div>  
                                    </div>

                                    <div class="form-group row">
                                    <span class="label-text col-md-2 col-form-label">Phone</span>
                                    <div class="col-md-3">
                                      <input type="text" name="text" class="form-control">
                                    </div>  
                                     <span class="label-text col-md-2 col-form-label">Phone</span>
                                    <div class="col-md-3">
                                      <input type="text" name="text" class="form-control">
                                    </div>  
                                    </div>
                                    
                                    <div class="form-group row">
                                    <span class="label-text col-md-2 col-form-label">Fax</span>
                                    <div class="col-md-3">
                                      <input type="text" name="text" class="form-control">
                                    </div>  
                                     <span class="label-text col-md-2 col-form-label">Fax</span>
                                    <div class="col-md-3">
                                      <input type="text" name="text" class="form-control">
                                    </div>  
                                    </div>  



                                    </div>                                 

                                    
                                    
                                    <div class="tab-pane fade" id="tab12">
                                    <br />
                                        <table class="table table-condensed">
    <thead>
      <tr>
        <th>Salutation</th>
        <th>First Name	</th>
        <th>Last Name	</th>
        <th>Email Address</th>
        <th>Work Phone	</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td></td>
         <td></td>
          <td></td>
           <td></td>
            <td></td>
             <td></td>
      </tr>      
    </tbody>
  </table>
                                    </div>
                                    <!-- Tab Pane End -->

                                    <div class="tab-pane fade" id="tab13">
                                    <br />
                                    <div class="col-md-8">
                                    <br />
                                        <center>
                                        Start adding custom fields for your contacts by going to Settings  Preferences  Customers and Vendors. You can add as many as Ten extra fields, as well as refine the address format of your customers from there.
                                        </center>
                                        </div>
                                    </div>
                                    <!-- Tab Pane End -->

                                    <div class="tab-pane fade" id="tab14">
                                         <div class="col-md-8">
                                    <br />
                                        <center>
                                       You've not created any Reporting Tags.<br />
Start creating reporting tags by going to More Settings  Reporting Tags
                                        </center>
                                        </div>
                                    </div>
                                    <!-- Tab Pane End -->

                                     <div class="tab-pane fade" id="tab15">
                                     <br />
                                    <div class="form-group row">
                                    <span class="label-text col-md-6 col-form-label">Remarks (For Internal Use)</span><br />
                                    <div class="clearfix"></div>
                                    <div class="col-md-6">
                                     <textarea name="textarea" class="form-control" spellcheck="false"></textarea>
                                    </div>
                                    </div>
                                    </div>
                                    <!-- Tab Pane End -->


                                </div>
                                </div>


                            </div>
                      
                        <!-- Panel End -->
                    </div> <div class="clearfix"></div>
                    </div>
                   
                   
            </section>
</asp:Content>

