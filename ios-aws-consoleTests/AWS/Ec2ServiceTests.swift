//
//  Ec2ServiceTests.swift
//  ios-aws-consoleTests
//
//  Created by Mark Haskins on 31/12/2018.
//  Copyright © 2018 Mark Haskins. All rights reserved.
//

import XCTest

@testable import ios_aws_console

class Ec2ServiceTests: CoreDataBaseTest {

    let describeRegionsResponse = """
<DescribeRegionsResponse xmlns="http://ec2.amazonaws.com/doc/2016-11-15/">
   <requestId>59dbff89-35bd-4eac-99ed-be587EXAMPLE</requestId>
   <regionInfo>
      <item>
         <regionName>us-east-1</regionName>
         <regionEndpoint>ec2.us-east-1.amazonaws.com</regionEndpoint>
      </item>
      <item>
         <regionName>eu-west-1</regionName>
         <regionEndpoint>ec2.eu-west-1.amazonaws.com</regionEndpoint>
      </item>
   </regionInfo>
</DescribeRegionsResponse>
"""

    let describeInstancesResponse = """
<DescribeInstancesResponse xmlns="http://ec2.amazonaws.com/doc/2016-11-15/">
    <requestId>8f7724cf-496f-496e-8fe3-example</requestId>
    <reservationSet>
        <item>
            <reservationId>r-1234567890abcdef0</reservationId>
            <ownerId>123456789012</ownerId>
            <groupSet/>
            <instancesSet>
                <item>
                    <instanceId>i-1234567890abcdef0</instanceId>
                    <imageId>ami-bff32ccc</imageId>
                    <instanceState>
                        <code>16</code>
                        <name>running</name>
                    </instanceState>
                    <privateDnsName>ip-192-168-1-88.eu-west-1.compute.internal</privateDnsName>
                    <dnsName>ec2-54-194-252-215.eu-west-1.compute.amazonaws.com</dnsName>
                    <reason/>
                    <keyName>my_keypair</keyName>
                    <amiLaunchIndex>0</amiLaunchIndex>
                    <productCodes/>
                    <instanceType>t2.micro</instanceType>
                    <launchTime>2018-05-08T16:46:19.000Z</launchTime>
                    <placement>
                        <availabilityZone>eu-west-1c</availabilityZone>
                        <groupName/>
                        <tenancy>default</tenancy>
                    </placement>
                    <monitoring>
                        <state>disabled</state>
                    </monitoring>
                    <subnetId>subnet-56f5f633</subnetId>
                    <vpcId>vpc-11112222</vpcId>
                    <privateIpAddress>192.168.1.88</privateIpAddress>
                    <ipAddress>54.194.252.215</ipAddress>
                    <sourceDestCheck>true</sourceDestCheck>
                    <groupSet>
                        <item>
                            <groupId>sg-e4076980</groupId>
                            <groupName>SecurityGroup1</groupName>
                        </item>
                    </groupSet>
                    <architecture>x86_64</architecture>
                    <rootDeviceType>ebs</rootDeviceType>
                    <rootDeviceName>/dev/xvda</rootDeviceName>
                    <blockDeviceMapping>
                        <item>
                            <deviceName>/dev/xvda</deviceName>
                            <ebs>
                                <volumeId>vol-1234567890abcdef0</volumeId>
                                <status>attached</status>
                                <attachTime>2015-12-22T10:44:09.000Z</attachTime>
                                <deleteOnTermination>true</deleteOnTermination>
                            </ebs>
                        </item>
                    </blockDeviceMapping>
                    <virtualizationType>hvm</virtualizationType>
                    <clientToken>xMcwG14507example</clientToken>
                    <tagSet>
                        <item>
                            <key>Name</key>
                            <value>Server_1</value>
                        </item>
                    </tagSet>
                    <hypervisor>xen</hypervisor>
                    <networkInterfaceSet>
                        <item>
                            <networkInterfaceId>eni-551ba033</networkInterfaceId>
                            <subnetId>subnet-56f5f633</subnetId>
                            <vpcId>vpc-11112222</vpcId>
                            <description>Primary network interface</description>
                            <ownerId>123456789012</ownerId>
                            <status>in-use</status>
                            <macAddress>02:dd:2c:5e:01:69</macAddress>
                            <privateIpAddress>192.168.1.88</privateIpAddress>
                            <privateDnsName>ip-192-168-1-88.eu-west-1.compute.internal</privateDnsName>
                            <sourceDestCheck>true</sourceDestCheck>
                            <groupSet>
                                <item>
                                    <groupId>sg-e4076980</groupId>
                                    <groupName>SecurityGroup1</groupName>
                                </item>
                            </groupSet>
                            <attachment>
                                <attachmentId>eni-attach-39697adc</attachmentId>
                                <deviceIndex>0</deviceIndex>
                                <status>attached</status>
                                <attachTime>2018-05-08T16:46:19.000Z</attachTime>
                                <deleteOnTermination>true</deleteOnTermination>
                            </attachment>
                            <association>
                                <publicIp>54.194.252.215</publicIp>
                                <publicDnsName>ec2-54-194-252-215.eu-west-1.compute.amazonaws.com</publicDnsName>
                                <ipOwnerId>amazon</ipOwnerId>
                            </association>
                            <privateIpAddressesSet>
                                <item>
                                    <privateIpAddress>192.168.1.88</privateIpAddress>
                                    <privateDnsName>ip-192-168-1-88.eu-west-1.compute.internal</privateDnsName>
                                    <primary>true</primary>
                                    <association>
                                    <publicIp>54.194.252.215</publicIp>
                                    <publicDnsName>ec2-54-194-252-215.eu-west-1.compute.amazonaws.com</publicDnsName>
                                    <ipOwnerId>amazon</ipOwnerId>
                                    </association>
                                </item>
                            </privateIpAddressesSet>
                            <ipv6AddressesSet>
                               <item>
                                   <ipv6Address>2001:db8:1234:1a2b::123</ipv6Address>
                               </item>
                           </ipv6AddressesSet>
                        </item>
                    </networkInterfaceSet>
                    <iamInstanceProfile>
                        <arn>arn:aws:iam::123456789012:instance-profile/AdminRole</arn>
                        <id>ABCAJEDNCAA64SSD123AB</id>
                    </iamInstanceProfile>
                    <ebsOptimized>false</ebsOptimized>
                    <cpuOptions>
                        <coreCount>1</coreCount>
                        <threadsPerCore>1</threadsPerCore>
                    </cpuOptions>
                </item>
            </instancesSet>
        </item>
    </reservationSet>
</DescribeInstancesResponse>
"""

    var ec2Service: Ec2Service!

    var ec2Dao: Ec2Dao!
    var regionDao: RegionDao!
    var profileDao: ProfileDao!

    override func setUp() {
        super.setUp()

        ec2Dao = Ec2Dao(container: mockPersistantContainer)
        regionDao = RegionDao(container: mockPersistantContainer)
        profileDao = ProfileDao(container: mockPersistantContainer)

        ec2Service = Ec2Service(ec2Dao: ec2Dao, regionDao: regionDao, profileDao: profileDao)
    }

    override func tearDown() {
        flushData(entityName: "EC2")
        flushData(entityName: "Region")
        
        super.tearDown()
    }

    func test_service() {
        XCTAssertEqual(ec2Service.service(), "ec2")
    }

    func test_endpoint() {
        XCTAssertEqual(ec2Service.endpoint(), "ec2.amazonaws.com")
    }

    func test_endpoint_with_region() {
        XCTAssertEqual(ec2Service.endpointWithRegion(region: "eu-west-1"), "ec2.eu-west-1.amazonaws.com")
    }

    func test_describe_instances_completion_handler() {

        ec2Service.describeInstancesCompletionHandler(instances: describeInstancesResponse.data(using: .utf8)!)

        let results = ec2Dao.getInstances()
        XCTAssertEqual(results?.count, 1)

    }

    func test_describe_regions_completion_handler() {

        ec2Service.describeRegionsCompletionHandler(regions: describeRegionsResponse.data(using: .utf8)!)

        let results = regionDao.getRegions()
        XCTAssertEqual(results?.count, 2)
    }
}
