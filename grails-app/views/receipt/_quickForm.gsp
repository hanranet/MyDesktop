<%@ page import="com.hanranet.mydesktop.receipts.Receipt" %>

<g:form controller="receipt" action="save" >

<table>
	<tr>
		<td>
			<div class='fieldcontain'>
                <input type="text" name="checkNo" size="5" value="Check No" style="color:#aaa" onfocus="this.value='';this.style.color='#000';this.onfocus='';"/>
             </div>
		</td>
		
		<td nowrap>
		    <div class='fieldcontain'>
                <input type="text" name="date" size="10"  autocomplete="off" id="datepicker" value=""/>
            </div>
		</td>
		<td>
			<div class='fieldcontain'>
                <input type="text" name="payee" size="20" value="Payee" style="color:#aaa" onfocus="this.value='';this.style.color='#000';this.onfocus='';"/>
             </div>
		</td>
		<td>
			<div class='fieldcontain'>
                <g:select optionKey="name" optionValue="name" name="category" from="${categoryList}" noSelection="['':'-Select a category-']"/>
            </div>
		</td>
		<td>
			<div class='fieldcontain'>
                <input type="text" name="debit" size="10" value="Debit" style="color:#aaa" onfocus="this.value='';this.style.color='#000';this.onfocus='';"/>
            </div>
		</td>
		<td>
			<div class='fieldcontain'>
                <input type="text" name="credit" size="10" value="Credit" style="color:#aaa" onfocus="this.value='';this.style.color='#000';this.onfocus='';"/>
            </div>
		</td>
		<td>
			<div class='fieldcontain'>
                <input type="text" name="memo" size="15" value="Memo" style="color:#aaa" onfocus="this.value='';this.style.color='#000';this.onfocus='';"/>
            </div>
		</td>
		<td>
        	<div class='fieldcontain'>
                <input type="hidden" name="owner" value="thanrahan" />
                <input type="hidden" name="createUser" value="thanrahan" />
                <input type="hidden" name="updateUser" value="thanrahan" />
            </div>
        </td>
		<td>
			<fieldset class="quickbuttons">
					<g:submitButton name="save" class="add" value="${message(code: 'default.button.create.label', default: 'Add')}" />
			</fieldset>
		</td>
	</tr>
</table>
</g:form>

			
			