<?php include('db_connect.php'); ?>
<?php 
function ordinal_suffix1($num){
    $num = $num % 100; // protect against large numbers
    if($num < 11 || $num > 13){
         switch($num % 10){
            case 1: return $num.'st';
            case 2: return $num.'nd';
            case 3: return $num.'rd';
        }
    }
    return $num.'th';
}
$astat = array("Not Yet Started","On-going","Closed");
 ?>
 <div class="col-12">
    <div class="card">
      <div class="card-body">
        Welcome <?php echo $_SESSION['login_name']. '! '.$_SESSION['login_view_folder'];
			if($_SESSION['login_user_type']==1){
				echo 'you have full access '. $_SESSION['login_user_type'];
			}elseif($_SESSION['login_user_type']==2){
				echo 'you have partial access'. $_SESSION['login_user_type'];
			}elseif($_SESSION['login_user_type']==3){
				echo 'you have limited access'.$_SESSION['login_user_type'];
			}else{
				echo 'the other type of user '. $_SESSION['login_user_type'];
			}
			echo $_SESSION['login_type'];
		?>
        <br>
        <div class="col-md-5">
       
        </div>
      </div>
    </div>
</div>
        <div class="row">
          <div class="col-12 col-sm-6 col-md-4">
            <div class="small-box bg-light shadow-sm border">
              <div class="inner">
                <h3><?php echo $conn->query("SELECT * FROM users WHERE user_type = 1 ")->num_rows; ?></h3>

                <p>Total Administrators</p>
              </div>
              <div class="icon">
                <i class="fa fa-user-friends"></i>
              </div>
            </div>
          </div>
           <div class="col-12 col-sm-6 col-md-4">
            <div class="small-box bg-light shadow-sm border">
              <div class="inner">
                <h3><?php echo $conn->query("SELECT * FROM users WHERE user_type = 2")->num_rows; ?></h3>

                <p>Total Reviewers</p>
              </div>
              <div class="icon">
               <i class="fa fa-users"></i>
              </div>
            </div>
          </div>
           <div class="col-12 col-sm-6 col-md-4">
            <div class="small-box bg-light shadow-sm border">
              <div class="inner">
                <h3><?php echo $conn->query("SELECT * FROM users WHERE user_type = 3")->num_rows; ?></h3>

                <p>Total Students</p>
              </div>
              <div class="icon">
			   <i class="fa ion-ios-people-outline"></i>
                
              </div>
            </div>
          </div>
          <div class="col-12 col-sm-6 col-md-4">
            <div class="small-box bg-light shadow-sm border">
              <div class="inner">
                <h3><?php echo $conn->query("SELECT * FROM class_list")->num_rows; ?></h3>

                <p>Total Papers</p>
              </div>
              <div class="icon">
                <i class="fa fa-list-alt"></i>
              </div>
            </div>
          </div>
		   <div class="col-12 col-sm-6 col-md-4">
            <div class="small-box bg-light shadow-sm border">
              <div class="inner">
                <h3><?php echo $conn->query("SELECT * FROM class_list")->num_rows; ?></h3>

                <p>Total Pending Papers</p>
              </div>
              <div class="icon">
                <i class="fa fa-list-alt"></i>
              </div>
            </div>
          </div>
		   <div class="col-12 col-sm-6 col-md-4">
            <div class="small-box bg-light shadow-sm border">
              <div class="inner">
                <h3><?php echo $conn->query("SELECT * FROM class_list")->num_rows; ?></h3>

                <p>Total Reviewed Papers</p>
              </div>
              <div class="icon">
                <i class="fa fa-list-alt"></i>
              </div>
            </div>
          </div>
      </div>