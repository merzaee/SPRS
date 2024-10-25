<?php include 'db_connect.php' ?>
<div class="col-lg-12">
	<div class="card card-outline card-success">
		<div class="card-header">
			<div class="card-tools">
				<a class="btn btn-block btn-sm btn-default btn-flat border-primary" href="./index.php?page=new_reviewer"><i class="fa fa-plus"></i> Add New Reviewer</a>
			</div>
		</div>
		<div class="card-body">
			<table class="table tabe-hover table-bordered" id="list">
				<thead>
					<tr>
						<th class="text-center">#</th>
						<th>Name</th>
						<th>Email</th>
						<th>Knowledge areas</th>
						<th>Total Shared</th>
						<th>Total Reviewed</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<?php
					$i = 1;
					$qry = $conn->query("SELECT
					users.id,
					concat( firstname, ' ', lastname ) AS name,
					users.email,
					users.PASSWORD,
					users.avatar,
					users.date_created,
					users.STATUS,
					users.user_type,
					users.knowledge_areas,
					COUNT( files.fileID ) AS total_shared
				FROM
					users
					LEFT JOIN files ON users.id = files.userID
					LEFT JOIN fileshare ON files.fileID = fileshare.fileID 
				WHERE
					users.user_type = 2 
				GROUP BY
					users.id");

					while($row= $qry->fetch_assoc()):
					?>
					<tr>
						<th class="text-center"><?php echo $i++ ?></th>
						<td><b><?php echo ucwords($row['name']) ?></b></td>
						<td><b><?php echo $row['email'] ?></b></td>
						<td><?php echo $row['knowledge_areas'] ?></td>
						<td><b><?php echo $row['total_shared'].' papers' ?></b></td>
						<td><b><?php echo $row['email'] ?></b></td>
						<td class="text-center">
							<button type="button" class="btn btn-default btn-sm btn-flat border-info wave-effect text-info dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
		                      Action
		                    </button>
		                    <div class="dropdown-menu" style="">						
							<a class="dropdown-item view_reviewer" href="javascript:void(0)" data-id="<?php echo $row['id'] ?>">View</a>
		                      <div class="dropdown-divider"></div>
		                    <a class="dropdown-item" href="./index.php?page=edit_reviewer&id=<?php echo $row['id'] ?>">Edit</a>
		                      <div class="dropdown-divider"></div>
		                    <a class="dropdown-item delete_user" href="javascript:void(0)" data-id="<?php echo $row['id'] ?>">Delete</a>
		                    </div>
						</td>
					</tr>	
				<?php endwhile; ?>
				</tbody>
			</table>
		</div>
	</div>
</div>
<script>
	$(document).ready(function(){
	$('.view_reviewer').click(function(){
		uni_modal("<i class='fa fa-id-card'></i> Reviewer Details","view_user.php?id="+$(this).attr('data-id'))
	})
	$('.delete_user').click(function(){
	_conf("Are you sure to delete this admin?","delete_user",[$(this).attr('data-id')])
	})
	$('#list').dataTable()
	})
	function delete_user($id){
		start_load()
		$.ajax({
			url:'ajax.php?action=delete_user',
			method:'POST',
			data:{id:$id},
			success:function(resp){
				if(resp==1){
					alert_toast("Data successfully deleted",'success')
					setTimeout(function(){
						location.reload()
					},1500)

				}
			}
		})
	}
</script>