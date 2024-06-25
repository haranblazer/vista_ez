<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="Purchase-order.aspx.cs" Inherits="secretadmin_Purchase_order" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2 class="head">
        <i class="fa fa-exchange" aria-hidden="true"></i>New Vendor</h2>
    <div class="panel panel-default">
        <div class="col-md-12">
            <div class="panel-content">
                <br />
                <!-- Form Group Start -->
                <div class="form-group row">
                    <span class="label-text col-md-2 col-form-label">Vendor Name</span>
                    <div class="col-md-4">
                        <asp:DropDownList ID="ddl_Vendor" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="form-group row">
                                    <span class="label-text col-md-2 col-form-label py-0">Deliver To</span>
                                    <div class="col-md-10 form-inline">
                                        <label class="form-radio mr-3">
                                            <input type="radio" name="radio02" value="1" class="form-radio-input" checked="">
                                            <span class="form-radio-label">Organization</span>
                                        </label>
                                        <label class="form-radio">
                                            <input type="radio" name="radio02" value="2" class="form-radio-input">
                                            <span class="form-radio-label">Customer</span>
                                        </label>
                                    </div>
                                </div>
                                
                <div class="form-group row">
                    <span class="label-text col-md-2 col-form-label ">Company Name</span>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_ComName" runat="server" CssClass="form-control" MaxLength="50"
                            placeholder="Company Name"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group row">
                <span class="label-text col-md-2 col-form-label">Purchase Order#</span>
                    <div class="col-md-3">
                    <input type="text" name="text" class="form-control">
                    </div>
                </div>
                 <div class="form-group row">
                 <span class="label-text col-md-2 col-form-label">Reference#</span>
                    <div class="col-md-3">
                    <input type="text" name="text" class="form-control">
                 </div>
                </div>
                 <div class="form-group row">
                <span class="label-text col-md-2 col-form-label">Date</span>
                    <div class="col-md-3">
                    <input type="text" name="text" class="form-control">
                    </div>
                </div>
                <div class="form-group row">
                <span class="label-text col-md-2 col-form-label">Expected Delivery Date
</span>
                    <div class="col-md-3">
                    <input type="text" name="text" class="form-control">
                    </div>
                    <span class="label-text col-md-2 col-form-label">Payment Terms
</span>
                    <div class="col-md-3">
                   <select name="select" class="form-control">
                                           <!-- <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>-->
                                        </select>
                    </div>

                </div>

                <div class="form-group row">
                <span class="label-text col-md-2 col-form-label">Shipment Preference
</span>
                    <div class="col-md-3">
                    <select name="select" class="form-control">
                                           <!-- <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>-->
                                        </select>
                    </div>

                </div>
                <div class="clearfix">
                </div>
                <br />
               <div class="table-responsive">
        
     
	<table class="table table-striped table-hover" cellspacing="0" rules="all" border="1" id="ctl00_ContentPlaceHolder1_GridView1" style="border-collapse:collapse;width: 100%">
		<tbody>
        <tr>
			<th>Item Details</th>
            <th>Account </th>
            <th>Quantity </th>
            <th>Rate </th>
            <th>Tax </th>
            <th>Amount </th>
		</tr>
	</tbody>
    <tr>
			<td>Item </td>
            <td>Item </td>
            <td>Item </td>
            <td>Item </td>
            <td>Item </td>
            <td>Item </td>
		</tr>
    </table>
    <div class="col-md-6">  <div class="input-group-prepend show">
                                                <button type="button" class="btn btn-rounded btn-success" data-toggle="dropdown" aria-expanded="true">Add another line +</button>
                                                
                                               
                                            </div></div>
    <div class="col-md-6">
      <div class="form-group row">
                <span class="label-text col-md-6 col-form-label">Sub Total
</span>
                    <div class="col-md-6 text-right">
                    0.00
                </div>    
    </div>
    <hr />

     <div class="form-group row">
                <span class="label-text col-md-4 col-form-label">Discount
</span>
                    <div class="col-md-4">
                     <input type="text" name="text" class="form-control text-right">
                </div>
                <div class="col-md-4 text-right">
                    0.00
                </div>    
    </div>
     <hr />
       <div class="form-group row">
         <div class="col-md-4">
                <input type="text" name="text" Placeholder="Adjustment" class="form-control">
                 </div>  
                    <div class="col-md-4 text-right">
                   <input type="text" name="text" class="form-control text-right">
                </div>   
                 <div class="col-md-4 text-right">
                    0.00
                </div> 
    </div>
  <div class="form-group row" style="background-color: #f9f8f8; border: 1px solid #ececec; padding: 10px 1%;">
                <span class="label-text col-md-6 col-form-label">Total
</span>
                    <div class="col-md-6 text-right">
                    0.00
                </div>    
    </div>


    </div>

    
    <div class="col-md-12 row" style="background-color: #f9f8f8; border: 1px solid #ececec; padding: 10px 1%;">
              <div class="col-md-4">
              <br />
              <div class="form-group row">
               <span class="label-text col-md-4 col-form-label"><small>Attach File(s)</small>
</span>
                    <div class="col-md-8">
                  <input type="file"  onchange="CheckUploadFile();">
                </div>   
                <div class="col-md-12">               
                       <br />
                             <span class="label-text col-md-12 col-form-label">
                    <small>You can upload a maximum of 5 files, 5MB each </small></span>
                      
                  <br /><br /><br />
                    <span class="label-text col-md-12 col-form-label">
                    Template: 'Standard Template' <i class="fa fa-pencil"></i>  </span>
                </div>
                </div>
              
              </div>
              <div class="col-md-8" style="border-left: 1px solid #ececec;"> 
              <div class="form-group row">
               <span class="label-text col-md-12 col-form-label">Terms & Conditions
</span>
                    <div class="col-md-12">
                   <textarea name="textarea" class="form-control" placeholder="Enter the terms and conditions of your business to be displayed in your transaction" spellcheck="false" style="height:120px;"></textarea>
                </div>   
                </div>
                 <div class="form-group row">
                 <span class="label-text col-md-12 col-form-label">Notes
</span>
                    <div class="col-md-12">
                   <textarea name="textarea" class="form-control" placeholder="Will be displayed on purchase order" spellcheck="false" ></textarea>
                </div> 
                </div>
              </div>  
    </div>

    
            </div>
            <!-- Panel End -->
        </div>
        <div class="clearfix">
        </div>
    </div> 
     <div class="clearfix">
                </div>
                <br />
    </div>
</asp:Content>
